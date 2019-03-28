module.exports = {
  publicPath: process.env.NODE_ENV === 'production'
    ? '/page-speed-insights-dashboard/'
    : '/',
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
