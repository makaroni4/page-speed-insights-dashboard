const ApexChartConfig = {
  chart: {
    height: 250,
    fontFamily: 'Roboto, sans-serif'
  },
  dataLabels: {
    enabled: false
  },
  stroke: {
    curve: 'straight'
  },
  toolbar: {
    tools: {
      selection: false
    }
  },
  markers: {
    size: 6,
    hover: {
      size: 10
    }
  },
  tooltip: {
    followCursor: false,
    theme: 'dark',
    x: {
      show: false
    },
    marker: {
      show: false
    },
    y: {
      title: {
        formatter: function() {
          return ''
        }
      }
    }
  },
  grid: {
    clipMarkers: false
  },
  yaxis: {
    tickAmount: 4
  },
  xaxis: {
    type: 'datetime'
  },
}

export default ApexChartConfig;
