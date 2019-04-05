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

    <div class="psi-dashboard__responsive-meme">
      <ResponsiveMeme />
    </div>
  </div>
</template>

<script>
import Header from './Header.vue';
import MetricCharts from './MetricCharts.vue';
import UrlsTable from './UrlsTable.vue';
import ResponsiveMeme from './ResponsiveMeme.vue';

export default {
  name: 'PSIDashboard',
  components: {
    Header,
    MetricCharts,
    UrlsTable,
    ResponsiveMeme
  }
};
</script>

<style lang="scss">
  .psi-dashboard {
    position: relative;

    &__container {
      padding-bottom: $px32;
    }

    &__urls-table {
      margin-bottom: $px48;
    }

    &__charts,
    &__urls-table {
      width: $px1024;
      margin-left: auto;
      margin-right: auto;
    }

    &__responsive-meme {
      position: fixed;
      bottom: $px24;
      left: 50%;
      transform: translateX(-50%);

      @media (min-width: $px960) {
        display: none;
      }
    }
  }
</style>
