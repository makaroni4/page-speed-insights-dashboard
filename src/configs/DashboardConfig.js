
const DashboardConfig = {
  deviceTypes: [
    "mobile",
    "desktop"
  ],
  metrics: [
    "speed_index",
    "first_contentful_paint",
    "first_meaningful_paint",
    "time_to_interactive",
  ],
  metricScales: {
    speed_index: 0,
    first_contentful_paint: 1,
    first_meaningful_paint: 1,
    time_to_interactive: 1,
  },
  metricsNames: {
    speed_index: "Speed Index",
    first_contentful_paint: "First Contentful Paint, sec",
    time_to_interactive: "Time to Interactive, sec",
    first_meaningful_paint: "First Meaningful Paint, sec",
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
        text: "First Contentful Paint, sec",
        align: "left"
      }
    },
    time_to_interactive: {
      title: {
        text: "Time to Interactive, sec",
        align: "left"
      }
    },
    first_meaningful_paint: {
      title: {
        text: "First Meaningful Paint, sec",
        align: "left"
      }
    }
  }
}

export default DashboardConfig;
