<template>
  <div class="chart">
    <div class="chart__body">
    </div>
  </div>
</template>

<style lang="scss">
  .chart {
    width: 500px;
    padding: 10px;
    margin-bottom: 24px;

    border: 1px solid #676767;

    /* HACK Since apex charts doesn't support showing toolbar on hover
    let's make a hack: */
    .apexcharts-toolbar {
      display: none !important;
    }

    &:hover .apexcharts-toolbar {
      display: flex !important;
    }
  }
</style>

<script>
import DashboardStore from '../stores/DashboardStore';
import DashboardConfig from '../configs/DashboardConfig';
import ApexChartConfig from '../configs/ApexChartConfig';

export default {
  name: 'Chart',
  data: function() {
    return {
      dashboardStore: DashboardStore.data,
      dashboardConfig: DashboardConfig,
      apexChartConfig: ApexChartConfig,
      chart: null
    };
  },
  props: [
    "metric",
    "deviceType",
    "url"
  ],
  beforeMount() {
    window.Apex = this.apexChartConfig;
    window.ApexCharts = ApexCharts;
  },
  mounted () {
    this.init();
  },
  render (createElement) {
    return createElement('div')
  },
  watch: {
    url() {
      if(!this.chart) {
        this.init()
      } else {
        this.chart.updateSeries([{
          data: this.timeline()
        }]);

        this.chart.updateOptions({
          yaxis: {
            min: 0,
            max: this.maxValue(),
          }
        });
      }
    }
  },
  methods: {
    timeline() {
      const deviceType = this.deviceType;
      const metric = this.metric;
      const seriesData = this.dashboardStore.urlData[this.url][deviceType];

      return Object.keys(seriesData).map((timestamp) => {
        return [new Date(timestamp), seriesData[timestamp][metric]];
      });
    },
    apexChartOptions() {
      var optionsLine = {
        chart: {
          id: this.deviceType + '-' + this.metric,
          type: 'line',
          toolbar: {
            show: true,
            tools: {
              download: true,
              selection: false,
              zoom: true,
              zoomin: false,
              zoomout: false,
              pan: false,
              reset: true
            }
          }
        },
        title: {
          text: this.deviceType + ' - ' + this.metric
        },
        colors: ['#008FFB'],
        series: [{
          data: this.timeline()
        }],
        yaxis: {
          min: 0,
          max: this.maxValue(),
          labels: {
            minWidth: 10
          },
          decimalsInFloat: 1
        }
      };

      let metricConfig = { ...this.dashboardConfig.chartOptions[this.metric] }
      if(metricConfig) {
        optionsLine = {
          ...optionsLine,
          ...metricConfig
        };
      }

      return optionsLine;
    },
    maxValue() {
      if(this.dashboardConfig.chartOptions[this.metric].yaxis) {
        return this.dashboardConfig.chartOptions[this.metric].yaxis.max;
      } else {
        const timeline = this.timeline();
        const values = timeline.map((value, _) => {
          return value[1];
        });

        return Math.ceil(Math.max(...values) + 1);
      }
    },
    init() {
      this.chart = new ApexCharts(this.$el, this.apexChartOptions());
      this.chart.render();
    },
  },
};
</script>
