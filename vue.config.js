module.exports = {
  publicPath: '<page-speed-insights-dashboard>',
  css: {
    loaderOptions: {
      sass: {
        data: `
          @import "@/styles/global.scss";
        `
      }
    }
  }
};
