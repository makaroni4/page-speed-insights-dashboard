const DashboardStore = {
  data: {
    urlData: null,
    urls: null,
    currentUrl: null,
  },
  init(rawData) {
    DashboardStore.data.urlData = rawData;
    DashboardStore.data.urls = Object.keys(rawData);
    DashboardStore.data.currentUrl = DashboardStore.data.urls[0];
  }
};

export default DashboardStore;
