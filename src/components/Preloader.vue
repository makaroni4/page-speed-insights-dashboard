<template>
  <div class="preloader">
    <div class="preloader__spinner">
    </div>
  </div>
</template>

<style lang="scss">
.preloader {
  position: absolute;
  width: 100%;
  height: 100%;
  top: 0;
  left: 0;
  display: flex;
  align-items: center;
  justify-content: center;

  &__spinner {
    width: $px48;
    height: $px48;
    background-color: $blue;

    margin: 100px auto;
    animation: sk-rotateplane 1.2s infinite ease-in-out;
  }
}

@keyframes sk-rotateplane {
  0% {
    transform: perspective(120px) rotateX(0deg) rotateY(0deg);
  } 50% {
    transform: perspective(120px) rotateX(-180.1deg) rotateY(0deg);
  } 100% {
    transform: perspective(120px) rotateX(-180deg) rotateY(-179.9deg);
  }
}
</style>
