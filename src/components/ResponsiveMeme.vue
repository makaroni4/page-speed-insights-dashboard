<template>
  <div class="responsive-meme" v-if="isVisible">
    <div class="responsive-meme__img">
    </div>

    <div v-on:click="removeMeme" class="responsive-meme__close">
      <CloseIcon />
    </div>
  </div>
</template>

<script>
import cookieMixin from '../mixins/cookieMixin';
import CloseIcon from './CloseIcon.vue';

export default {
  name: 'ResponsiveMeme',
  mixins: [cookieMixin],
  data: function () {
    return {
      isVisible: false
    }
  },
  components: {
    CloseIcon
  },
  methods: {
    removeMeme() {
      this.isVisible = false;

      this.$setCookie("hide-meme", true, 365);
    },
  },
  created() {
    this.isVisible = !this.$getCookie("hide-meme");
  }
};
</script>

<style lang="scss">
  .responsive-meme {
    position: relative;
    width: $px496;
    height: $px320;

    &__img {
      width: 100%;
      height: 100%;

      background: url("../assets/meme.jpg");
      background-size: contain;
      background-repeat: no-repeat;
    }

    &__close {
      width: $px32;
      height: $px32;
      position: absolute;
      top: $px8;
      right: $px8;
    }
  }
</style>
