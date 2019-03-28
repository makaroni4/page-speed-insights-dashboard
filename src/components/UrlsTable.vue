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
      <tr v-for="url in dashboardStore.urls" v-on:click="setCurrentUrl(url)" class="urls-table__row">
        <td class="urls-table__url">
          {{ url }}

          <a class="urls-table__open-psi-report" v-bind:href="PSIUrl(dashboardStore.currentUrl)" target="_blank"></a>
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

    border-radius: 2px;

    &,
    & th,
    & td {
      border: 1px solid #676767;
    }

    th {
      padding: 5px;

      font-size: 12px;
      line-height: 14px;
      text-align: center;

      &.urls-table__device-type-row {
        line-height: 28px;
      }

      &:first-child {
        width: 350px;
      }
    }

    & td {
      width: 20px;
      padding: 5px;

      &:not(:first-child) {
        text-align: center;
      }
    }

    &__url {
      font-size: 14px;
      line-height: 18px;

      word-wrap: break-word;
    }

    &__row {
      height: 48px;
    }

    &__row:hover td {
      opacity: 0.9;
    }

    &__metric-name,
    &__row {
      cursor: pointer;
    }

    &__open-psi-report {
      display: inline-block;
      width: 10px;
      height: 10px;

      background: url("../assets/external-link.svg");
      background-size: contain;
      background-repeat: no-repeat;
    }

    &__metric-value--fast {
      background-color: #48e048;

      color: #270707;
    }

    &__metric-value--average {
      background-color: #F9D423;

      color: #270707;
    }

    &__metric-value--slow {
      background-color: #FF4E50;

      color: #270707;
    }

    &__metric-name {
      position: relative;
    }

    &__sort-direction {
      display: inline-block;
      width: 7px;
      height: 7px;
      position: absolute;
      right: 4px;
      bottom: 6px;

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
      var urlData = this.dashboardStore.urlData[url][deviceType];

      var latestTimestamp = Object.keys(urlData).sort(function(a, b){
        return new Date(b) - new Date(a);
      })[0];

      return urlData[latestTimestamp][metricName];
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
  }
}
</script>
