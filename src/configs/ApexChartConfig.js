const ApexChartConfig = {
  chart: {
    height: 250,
    fontFamily: 'Roboto, sans-serif'
  },
  dataLabels: {
    enabled: false
  },
  stroke: {
    curve: 'straight',
    width: 2
  },
  toolbar: {
    tools: {
      selection: false
    }
  },
  markers: {
    size: 3,
    hover: {
      size: 5
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
