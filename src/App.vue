<template>
  <PSIDashboard v-if="this.currentUrl" />
</template>

<script>
import axios from 'axios';
import PSIDashboard from './components/PSIDashboard.vue';

export default {
  name: 'app',
  data: function () {
    return globalData;
  },
  components: {
    PSIDashboard,
  },
  created() {
    axios
      .get('data/data.json')
      .then((response) => {
        this.reportData = response.data;
        this.urls = Object.keys(this.reportData);
        this.currentUrl = this.urls[0];
      });
  },
};
</script>

<style lang="scss">
</style>
