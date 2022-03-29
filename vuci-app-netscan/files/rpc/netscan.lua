local os = require "os"

local M = {}

function M.scan_network(params)
    local cmd = "lua /usr/bin/nethosts"
    if params.ipv4subnet ~= nil then
        cmd = cmd .. " -i "..params.ipv4subnet
    end
    if params.ports then
        cmd = cmd .. " --ports"
    end
    if params.range ~= nil and params.range ~= "" then
        cmd = cmd .. " --range " .. params.range
    end
    cmd = cmd .." &> /tmp/network_scan.json &"
    os.execute(cmd)

    return {ok = true, message = "Scan started", command = cmd, params = params}
end

function M.get_results()
    local file = io.open("/tmp/network_scan.json", "r")
    if file == nil then
        return {ok = false, message = "Scan in progress"}
    end
    local size = file:seek("end")
    if size == 0 then
        return {ok = false, message = "Scan in progress"}
    end
    local lines = {}
    for line in io.lines("/tmp/network_scan.json") do
        lines[#lines + 1] = line
    end
    file:close()
    return {ok = true, data = lines}
end

function M.stop_scan()
    os.execute("pgrep -f \"lua nethosts\" | xargs kill -9")
    os.execute("pidof nmap | xargs kill -9")
    return {ok = true, message = "Scan stopped"}
end

return M
