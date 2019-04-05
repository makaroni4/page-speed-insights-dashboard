<template>
  <header class="header">
    <div class="header__container">
      <div class="header__logo">
        PageSpeed Insights Dashboard
      </div>

      <ul class="header__menu">
        <li>
          <a class="header__github-link" href="https://github.com/makaroni4/page_speed_insights_dashboard" target="_blank">Github repo</a>
        </li>
      </ul>
    </div>
  </header>
</template>

<style lang="scss">
  .header {
    padding: $px16 0;

    &__logo {
      font-weight: 900;
    }

    &__container {
      width: $px1024;
      margin: 0 auto;
      display: flex;
      align-items: center;
      justify-content: space-between;
    }

    &__menu {
      display: block;

      list-style: none;
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
