<template>
  <PSIDashboard v-if="hasData()" />
  <Preloader v-else />
</template>

<script>
import axios from 'axios';
import PSIDashboard from './components/PSIDashboard.vue';
import Preloader from './components/Preloader';
import DashboardStore from './stores/DashboardStore';

export default {
  name: 'app',
  data: function () {
    return {
      dashboardStore: DashboardStore.data
    };
  },
  components: {
    PSIDashboard,
    Preloader,
  },
  methods: {
    hasData: function() {
      return this.dashboardStore.urls !== null;
    }
  },
  created() {
    axios
      .get('data/data.json')
      .then((response) => {
        DashboardStore.init(response.data);
      });
  },
};
</script>

<style lang="scss">
</style>
