<template>
  <footer class="footer">
    <div class="footer__container">
      <div class="footer__left">
        Made with <span class="footer__heart"></span> and <span class="footer__coffee"></span> by <a href="https://twitter.com/makaroni4">@makaroni4</a>
      </div>

      <div class="footer__right">
        <a class="footer__github-link" href="https://github.com/makaroni4/page_speed_insights_dashboard" target="_blank">PageSpeed Insights Dashboard on Github </a>
      </div>
    </div>


  </footer>
</template>

<style lang="scss">
  .footer {
    padding-bottom: $px32;

    &__container {
      width: $px1024;
      margin: 0 auto;
      display: flex;
      align-items: center;
      justify-content: space-between;
    }

    &__heart {
      display: inline-block;
      width: $px16;
      height: $px16;

      background: url("../assets/heart.svg");
      background-size: contain;
      background-repeat: no-repeat;
    }

    &__coffee {
      display: inline-block;
      width: $px16;
      height: $px16;

      background: url("../assets/coffee.svg");
      background-size: contain;
      background-repeat: no-repeat;
    }

    &__github-link {
      position: relative;

      &:before {
        display: inline-block;
        position: absolute;
        bottom: 0;
        left: -$px32;
        width: $px24;
        height: $px24;

        background: url("../assets/github.svg");
        background-size: contain;
        background-repeat: no-repeat;

        content: "";
      }
    }
  }
</style>

