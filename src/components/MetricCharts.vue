<template>
  <div class="metric-charts">
    <div class="metric-charts__header">
      <div class="metric-charts__current-url">
        {{ dashboardStore.currentUrl }}
      </div>
    </div>

    <div class="metric-charts__datepicker">
      <div class="metric-charts__date">
        <label>From</label>
        <Datepicker :value="startDate" @selected="startDateChanged" />
      </div>

      <div class="metric-charts__date">
        <label>To</label>
        <Datepicker :value="finishDate" @selected="finishDateChanged" />
      </div>
    </div>

    <div class="metric-charts__report">
      <div class="metric-charts__column">
        <div class="metric-charts__device-type metric-charts__device-type--mobile">
          Mobile
        </div>

        <div class="metric-charts__charts">
          <div class="metric-charts__chart" v-for="metric in dashboardConfig.metrics" :key="`mobile-${metric}`">
            <Chart
              :metric="metric"
              :deviceType="'mobile'"
              :url="dashboardStore.currentUrl"
              :startDate="startDate"
              :finishDate="finishDate" />
          </div>
        </div>
      </div>

      <div class="metric-charts__column">
        <div class="metric-charts__device-type metric-charts__device-type--desktop">
          Desktop
        </div>

        <div class="metric-charts__chart" v-for="metric in dashboardConfig.metrics" :key="`desktop-${metric}`">
          <Chart
            :metric="metric"
            :deviceType="'desktop'"
            :url="dashboardStore.currentUrl"
            :startDate="startDate"
            :finishDate="finishDate" />
        </div>
      </div>
    </div>
  </div>
</template>

<style lang="scss">
  .metric-charts {
    &__current-url {
      font-size: $px24;
      line-height: $px32;
    }

    &__datepicker {
      display: flex;
      margin-bottom: $px32;
    }

    &__date {
      &:not(:first-child) {
        margin-left: $px16;
      }
    }

    &__header {
      margin-bottom: $px32;
    }

    &__report {
      display: flex;
      justify-content: space-between;
    }

    &__device-type {
      position: relative;
      padding-left: $px32;

      margin-bottom: $px24;

      font-size: $px24;
      line-height: $px24;

      &--mobile {
        &:before {
          display: block;
          position: absolute;
          bottom: 0;
          left: 0;
          width: $px24;
          height: $px24;

          background: url("../assets/mobile.svg");
          background-size: contain;
          background-repeat: no-repeat;

          content: "";
        }
      }

      &--desktop {
        &:before {
          display: block;
          position: absolute;
          bottom: 0;
          left: 0;
          width: $px24;
          height: $px24;

          background: url("../assets/desktop.svg");
          background-size: contain;
          background-repeat: no-repeat;

          content: "";
        }
      }
    }
  }
</style>


<script>
import Chart from './Chart.vue';
import DashboardStore from '../stores/DashboardStore';
import DashboardConfig from '../configs/DashboardConfig';
import Datepicker from 'vuejs-datepicker';

const startDate = new Date();
startDate.setMonth(startDate.getMonth() - 2);

const finishDate = new Date();

export default {
  name: 'MetricCharts',
  data: function () {
    return {
      startDate: startDate,
      finishDate: finishDate,
      dashboardStore: DashboardStore.data,
      dashboardConfig: DashboardConfig,
    };
  },
  components: {
    Chart,
    Datepicker
  },
  methods: {
    startDateChanged(newDate) {
      this.startDate = newDate;
    },
    finishDateChanged(newDate) {
      this.finishDate = newDate;
    }
  }
}
</script>
