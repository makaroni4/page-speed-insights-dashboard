const DashboardConfig = {
  deviceTypes: [
    "mobile",
    "desktop"
  ],
  metrics: [
    "speed_index",
    "first_contentful_paint",
    "time_to_interactive",
    "first_meaningful_paint"
  ],
  metricsNames: {
    speed_index: "Speed Index",
    first_contentful_paint: "First Contentful Paint",
    time_to_interactive: "Time to Interactive",
    first_meaningful_paint: "First Meaningful Paint",
  },
  chartOptions: {
    speed_index: {
      title: {
        text: "Speed Index",
        align: "left"
      },
      yaxis: {
        min: 0,
        max: 100
      }
    },
    first_contentful_paint: {
      title: {
        text: "First Contentful Paint",
        align: "left"
      }
    },
    time_to_interactive: {
      title: {
        text: "Time to Interactive",
        align: "left"
      }
    },
    first_meaningful_paint: {
      title: {
        text: "First Meaningful Paint",
        align: "left"
      }
    }
  }
}

export default DashboardConfig;
