<template>
  <table class="urls-table">
    <thead>
      <tr>
        <th rowspan="2">URL</th>

        <th class="urls-table__device-type-row" colspan="4">Mobile</th>
        <th class="urls-table__device-type-row" colspan="4">Desktop</th>
      </tr>

      <tr>
        <th
          class="urls-table__metric-name"
          v-for="metric in dashboardConfig.metrics"
          v-on:click="sortBy('mobile', metric)"
          v-bind:key="'th-' + metric + '-mobile'">
            {{ dashboardConfig.metricsNames[metric] }}
            <span v-if="sortDeviceType === 'mobile' && sortMetric === metric" v-bind:class="sortDirectionCssClass()"></span>
        </th>

        <th
          class="urls-table__metric-name"
          v-for="metric in dashboardConfig.metrics"
          v-on:click="sortBy('desktop', metric)"
          v-bind:key="'th-' + metric + '-desktop'">
            {{ dashboardConfig.metricsNames[metric] }}
            <span v-if="sortDeviceType === 'desktop' && sortMetric === metric" v-bind:class="sortDirectionCssClass()"></span>
        </th>
      </tr>
    </thead>

    <tbody>
      <tr v-for="url in dashboardStore.urls" v-on:click="setCurrentUrl(url)" v-bind:class="urlRowCssClass(url)">
        <td class="urls-table__url">
          {{ url }}

          <a
            class="urls-table__open-url"
            v-bind:href="dashboardStore.currentUrl"
            target="_blank">
          </a>

          <a
            class="urls-table__open-psi-report"
            v-bind:href="PSIUrl(dashboardStore.currentUrl)"
            target="_blank">
          </a>
        </td>

        <td v-for="metric in dashboardConfig.metrics" v-bind:class="tdClass(url, 'mobile')">
          {{ latestMetric(url, "mobile", metric) }}
        </td>

        <td v-for="metric in dashboardConfig.metrics" v-bind:class="tdClass(url, 'desktop')">
          {{ latestMetric(url, "desktop", metric) }}
        </td>
      </tr>
    </tbody>
  </table>
</template>

<style lang="scss">
  .urls-table {
    border-collapse: collapse;
    table-layout: fixed;
    width: 100%;

    border-radius: $px2;

    &,
    & th,
    & td {
      border: $px1 solid $grey;
    }

    th {
      padding: $px4;

      font-size: $px12;
      line-height: $px16;
      text-align: center;

      &.urls-table__device-type-row {
        line-height: $px32;
      }

      &:first-child {
        width: $px320;
      }
    }

    & td {
      width: $px24;
      padding: $px4;

      &:not(:first-child) {
        text-align: center;
      }
    }

    &__url {
      font-size: $px12;
      line-height: $px16;

      word-wrap: break-word;
    }

    &__row {
      height: $px48;

      &--active td {
        opacity: 0.8;
      }

      &:hover td {
        opacity: 0.8;
      }
    }

    &__metric-name,
    &__row {
      cursor: pointer;
    }

    &__open-url {
      display: inline-block;
      width: $px12;
      height: $px12;
      margin-left: $px4;

      background: url("../assets/external-link.svg");
      background-size: contain;
      background-repeat: no-repeat;
    }

    &__open-psi-report {
      display: inline-block;
      width: $px12;
      height: $px12;
      margin-left: $px4;

      background: url("../assets/psi-link.svg");
      background-size: contain;
      background-repeat: no-repeat;
    }

    &__metric-value--fast {
      background-color: $green;

      color: $black;
    }

    &__metric-value--average {
      background-color: $orange;

      color: $black;
    }

    &__metric-value--slow {
      background-color: $red;

      color: $black;
    }

    &__metric-name {
      position: relative;
    }

    &__sort-direction {
      display: inline-block;
      width: $px8;
      height: $px8;
      position: absolute;
      right: $px4;
      bottom: $px4;

      &--down {
        background: url("../assets/triangle.svg");
        background-size: contain;
        background-repeat: no-repeat;
      }

      &--up {
        background: url("../assets/triangle.svg");
        background-size: contain;
        background-repeat: no-repeat;

        transform: scaleY(-1);
      }
    }
  }
</style>

<script>
import DashboardStore from '../stores/DashboardStore';
import DashboardConfig from '../configs/DashboardConfig';

export default {
  name: 'UrlsTable',
  data: function () {
    return {
      dashboardStore: DashboardStore.data,
      dashboardConfig: DashboardConfig,
      sortDirection: 1,
      sortDeviceType: "mobile",
      sortMetric: "speed_index"
    };
  },
  methods: {
    urlRowCssClass(url) {
      let cssClass = "urls-table__row";

      if(this.dashboardStore.currentUrl === url) {
        cssClass += " urls-table__row--active";
      }

      return cssClass;
    },
    PSIUrl(url) {
      return `https://developers.google.com/speed/pagespeed/insights/?url=${url}`;
    },
    sortDirectionCssClass() {
      return "urls-table__sort-direction urls-table__sort-direction--" + (this.sortDirection === 1 ? 'down' : 'up');
    },
    speedIndexScale(url, deviceType) {
      var latestSpeedIndex = this.latestMetric(url, deviceType, "speed_index");

      if(latestSpeedIndex > 89) {
        return "fast";
      } else if (latestSpeedIndex > 49) {
        return "average";
      } else {
        return "slow";
      }
    },
    setCurrentUrl(url) {
      this.dashboardStore.currentUrl = url;
    },
    latestMetric(url, deviceType, metricName) {
      const urlData = this.dashboardStore.urlData[url][deviceType];

      const latestTimestamp = Object.keys(urlData).sort(function(a, b){
        return new Date(b) - new Date(a);
      })[0];

      const latestValue = urlData[latestTimestamp][metricName];

      return latestValue.toFixed(this.dashboardConfig.metricScales[metricName]);
    },
    sortBy(deviceType, metric, sortDirection = this.sortDirection) {
      this.sortDeviceType = deviceType;
      this.sortMetric = metric;

      this.dashboardStore.urls.sort((a, b) => {
        return sortDirection * (this.latestMetric(b, this.sortDeviceType, this.sortMetric) - this.latestMetric(a, this.sortDeviceType, this.sortMetric))
      });

      this.sortDirection *= -1;
    },
    tdClass(url, deviceType) {
      return "urls-table__metric-value urls-table__metric-value--" + this.speedIndexScale(url, deviceType)
    }
  },
  mounted() {
    this.sortBy("mobile", "speed_index", -1);

    this.dashboardStore.currentUrl = this.dashboardStore.urls[0];
  }
}
</script>
