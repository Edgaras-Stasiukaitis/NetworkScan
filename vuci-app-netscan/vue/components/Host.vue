<template>
    <div class="network">
        <a-popover :title="network.vendor">
            <template slot="content">
                <p><b>IP address:</b> {{ network.ipNumber }}</p>
                <p><b>MAC address:</b> {{ network.macAddress }}</p>
                <p v-if="network.ports.length !== 0"><a-tag color="green">Open ports</a-tag>: {{ network.ports }}</p>
            </template>
            <div v-if="network.ports.length !== 0" class="indicator">
                <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" fill="#16c94f" class="bi bi-dot" viewBox="0 0 16 16">
                    <path d="M8 9.5a1.5 1.5 0 1 0 0-3 1.5 1.5 0 0 0 0 3z"/>
                </svg>
            </div>
            <div v-if="network.vendor === '(Teltonika)' || network.host === 'Known'">
                <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" fill="#1890ff" class="bi bi-router" viewBox="0 0 16 16">
                    <path d="M5.525 3.025a3.5 3.5 0 0 1 4.95 0 .5.5 0 1 0 .707-.707 4.5 4.5 0 0 0-6.364 0 .5.5 0 0 0 .707.707Z"/>
                    <path d="M6.94 4.44a1.5 1.5 0 0 1 2.12 0 .5.5 0 0 0 .708-.708 2.5 2.5 0 0 0-3.536 0 .5.5 0 0 0 .707.707ZM2.5 11a.5.5 0 1 1 0-1 .5.5 0 0 1 0 1Zm4.5-.5a.5.5 0 1 0 1 0 .5.5 0 0 0-1 0Zm2.5.5a.5.5 0 1 1 0-1 .5.5 0 0 1 0 1Zm1.5-.5a.5.5 0 1 0 1 0 .5.5 0 0 0-1 0Zm2 0a.5.5 0 1 0 1 0 .5.5 0 0 0-1 0Z"/>
                    <path d="M2.974 2.342a.5.5 0 1 0-.948.316L3.806 8H1.5A1.5 1.5 0 0 0 0 9.5v2A1.5 1.5 0 0 0 1.5 13H2a.5.5 0 0 0 .5.5h2A.5.5 0 0 0 5 13h6a.5.5 0 0 0 .5.5h2a.5.5 0 0 0 .5-.5h.5a1.5 1.5 0 0 0 1.5-1.5v-2A1.5 1.5 0 0 0 14.5 8h-2.306l1.78-5.342a.5.5 0 1 0-.948-.316L11.14 8H4.86L2.974 2.342ZM14.5 9a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-.5.5h-13a.5.5 0 0 1-.5-.5v-2a.5.5 0 0 1 .5-.5h13Z"/>
                    <path d="M8.5 5.5a.5.5 0 1 1-1 0 .5.5 0 0 1 1 0Z"/>
                </svg>
            </div>
            <div v-else>
                <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" fill="#1890ff" class="bi bi-pc-display-horizontal" viewBox="0 0 16 16">
                    <path d="M1.5 0A1.5 1.5 0 0 0 0 1.5v7A1.5 1.5 0 0 0 1.5 10H6v1H1a1 1 0 0 0-1 1v3a1 1 0 0 0 1 1h14a1 1 0 0 0 1-1v-3a1 1 0 0 0-1-1h-5v-1h4.5A1.5 1.5 0 0 0 16 8.5v-7A1.5 1.5 0 0 0 14.5 0h-13Zm0 1h13a.5.5 0 0 1 .5.5v7a.5.5 0 0 1-.5.5h-13a.5.5 0 0 1-.5-.5v-7a.5.5 0 0 1 .5-.5ZM12 12.5a.5.5 0 1 1 1 0 .5.5 0 0 1-1 0Zm2 0a.5.5 0 1 1 1 0 .5.5 0 0 1-1 0ZM1.5 12h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1 0-1ZM1 14.25a.25.25 0 0 1 .25-.25h5.5a.25.25 0 1 1 0 .5h-5.5a.25.25 0 0 1-.25-.25Z"/>
                </svg>
            </div>
        </a-popover>
        <div class="known-host" v-if="network.host==='Known'">
            <a-tag color="green">Gateway</a-tag>
            <label>{{ this.network.ipNumber }}</label>
            <label v-if="hostnames">{{ this.network.vendor }}</label>
        </div>
        <div class="unknown-host" v-else>
            <label>{{ this.network.ipNumber }}</label>
            <label v-if="hostnames">{{ this.network.vendor }}</label>
        </div>
    </div>
</template>

<script>
export default {
  props: ['network', 'hostnames'],
  methods: {
    displayHost () {
      if (this.network.ports.length === 0) return this.network.ipNumber
      return `${this.network.ipNumber}: ${this.network.ports}`
    }
  }
}
</script>

<style>
.known-host {
    display: flex;
    flex-direction: column;
    font-weight: bold;
    justify-content: center;
    text-align: center;
}
.unknown-host {
    display: flex;
    flex-direction: column;
    justify-content: center;
    text-align: center;
}
.ant-tag-green {
    margin: auto;
}
.network {
    position: relative;
    z-index: 10;
}
label {
    margin-top: 5px;
    font-size: 14px;
}
.indicator {
    position: absolute;
    left: 0;
    right: 0;
    top: 0;
    margin-top: -25px;
}
</style>
