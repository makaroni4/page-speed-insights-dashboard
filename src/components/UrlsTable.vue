<template>
  <table class="urls-table">
    <thead>
      <tr>
        <th rowspan="2">URL</th>

        <th colspan="5">Mobile</th>

        <th colspan="5">Desktop</th>
      </tr>

      <tr>
        <th class="urls-table__metric-name" v-on:click="sortBy('mobile', 'speed_index')">Speed Index</th>
        <th class="urls-table__metric-name" v-on:click="sortBy('mobile', 'first_contentful_paint')">First Contentful Paint</th>
        <th class="urls-table__metric-name" v-on:click="sortBy('mobile', 'time_to_interactive')">Time To Interactive</th>
        <th class="urls-table__metric-name" v-on:click="sortBy('mobile', 'first_meaningful_paint')">First Meaningful Paint</th>
        <th class="urls-table__metric-name" v-on:click="sortBy('mobile', 'first_cpu_idle')">First CPU Idle</th>

        <th class="urls-table__metric-name" v-on:click="sortBy('desktop', 'speed_index')">Speed Index</th>
        <th class="urls-table__metric-name" v-on:click="sortBy('desktop', 'first_contentful_paint')">First Contentful Paint</th>
        <th class="urls-table__metric-name" v-on:click="sortBy('desktop', 'time_to_interactive')">Time To Interactive</th>
        <th class="urls-table__metric-name" v-on:click="sortBy('desktop', 'first_meaningful_paint')">First Meaningful Paint</th>
        <th class="urls-table__metric-name" v-on:click="sortBy('desktop', 'first_cpu_idle')">First CPU Idle</th>
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
      border: 1px solid #E4E4E4;
    }

    & th {
      padding: 5px 0;

      font-size: 12px;
      line-height: 14px;
      text-align: center;

      &:first-child {
        width: 300px;
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
      background-color: #178239;
    }

    &__metric-value--average {
      background-color: #e67700;
    }

    &__metric-value--slow {
      background-color: #c7221f;
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
      sortDirection: 1
    };
  },
  methods: {
    PSIUrl(url) {
      return `https://developers.google.com/speed/pagespeed/insights/?url=${url}`;
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
      this.dashboardStore.urls.sort((a, b) => {
        return sortDirection * (this.latestMetric(b, deviceType, metric) - this.latestMetric(a, deviceType, metric))
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
