<template>
  <div class="chart">
    <div class="chart__body">
    </div>
  </div>
</template>

<style lang="scss">
  .chart {
    width: 475px;
    padding: 10px;
    margin-bottom: 10px;

    border: 1px solid #E4E4E4;
    border-radius: 2px;

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
export default {
  name: 'Chart',
  data: function() {
    return {
      chartOptions: globalData.chartOptions,
      chart: null
    };
  },
  props: [
    "metric",
    "series",
    "deviceType"
  ],
  beforeMount() {
    window.ApexCharts = ApexCharts;
  },
  mounted () {
    this.init();
  },
  render (createElement) {
    return createElement('div')
  },
  watch: {
    series: function(newVal, oldVal) {
      if(!this.chart) {
        this.init()
      } else {
        this.chart.updateSeries([{
          data: this.timeline()
        }]);
      }
    }
  },
  methods: {
    timeline() {
      const deviceType = this.deviceType;
      const metric = this.metric;
      const seriesData = this.series[deviceType];

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
          max: this.maxValue() + 1,
          labels: {
            minWidth: 40
          },
          decimalsInFloat: 1
        }
      };

      if(this.chartOptions[this.metric]) {
        optionsLine = {
          ...optionsLine,
          ...this.chartOptions[this.metric]
        };
      }

      return optionsLine;
    },
    maxValue() {
      const deviceType = this.deviceType;
      const metric = this.metric;
      const seriesData = this.series[deviceType];

      const values = Object.keys(seriesData).map((timestamp) => {
        return seriesData[timestamp][metric];
      });

      return Math.max(...values);
    },
    init() {
      this.chart = new ApexCharts(this.$el, this.apexChartOptions());
      this.chart.render();
    },
  },
};
</script>
