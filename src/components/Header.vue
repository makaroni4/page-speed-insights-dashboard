<template>
  <header class="header">
    <div class="header__container">
      <div class="header__logo">
        PageSpeed Insights Dashboard
      </div>

      <ul class="header__menu">
        <li>
          <a href="https://github.com/makaroni4/page_speed_insights_dashboard">Github repo</a>
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
  }
</style>
