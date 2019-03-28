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
  .psi-dashboard {
    &__container {
      padding-bottom: 30px;
    }

    &__header {
      margin-bottom: 40px;
    }

    &__urls-table {
      margin-bottom: 40px;
    }

    &__charts,
    &__urls-table {
      width: 960px;
      margin-left: auto;
      margin-right: auto;
    }
  }
</style>
