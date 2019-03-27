<template>
  <div class="psi-dashboard">
    <div class="psi-dashboard__header">
      <Header />
    </div>
    <div class="psi-dashboard__urls-table">
      <UrlsTable />
    </div>

    <div class="psi-dashboard__charts">
      <MetricCharts />
    </div>
  </div>
</template>

<script>
import Header from './Header.vue';
import MetricCharts from './MetricCharts.vue';
import UrlsTable from './UrlsTable.vue';

export default {
  name: 'PSIDashboard',
  components: {
    Header,
    MetricCharts,
    UrlsTable
  }
};
</script>

<style lang="scss">
  html {
    box-sizing: border-box;
  }

  *, *:before, *:after {
    box-sizing: inherit;
  }

  body {
    font-family: "Roboto", sans-serif;
  }

  .psi-dashboard {
    width: 960px;
    margin: 0 auto;
    padding: 30px 0;

    &__urls-table {
      margin-bottom: 40px;
    }
  }
</style>
