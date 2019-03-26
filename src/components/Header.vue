<template>
  <header class="header">
    <div class="header__container">
      <div class="header__logo">
        PSI Dashboard
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
    padding: 15px 0;

    background-color: #3f85f7;

    &__container {
      width: 960px;
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
