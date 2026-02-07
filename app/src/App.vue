<template>
  <div class="valentine-app" :class="{ 'said-yes': accepted }">
    <!-- Floating hearts background -->
    <div class="floating-hearts" v-if="!accepted">
      <span v-for="n in 20" :key="n" class="float-heart" :style="heartStyle(n)">♥</span>
    </div>

    <!-- Celebration overlay -->
    <div v-if="accepted" class="celebration-overlay">
      <div class="burst-hearts" :key="burstKey">
        <span v-for="n in 50" :key="'burst-' + n" class="burst-heart" :style="burstStyle(n)">{{ randomHeart() }}</span>
      </div>
    </div>

    <!-- Main content -->
    <div class="content-wrapper">
      <h1 class="title" v-if="!accepted">
        <span class="heart-icon">💕</span>
        Will You Be My Valentine?
        <span class="heart-icon">💕</span>
      </h1>
      <h1 class="title celebration-title" v-else>
        🥰 Yay!!! 🥰
      </h1>

      <!-- Photo Carousel -->
      <Carousel />

      <!-- Valentine question -->
      <div class="question-section" v-if="!accepted">
        <button class="yes-btn" @click="sayYes">
          <span class="btn-heart">❤️</span>
          Yes!!
          <span class="btn-heart">❤️</span>
        </button>
      </div>

      <!-- After acceptance message -->
      <div class="accepted-section" v-else>
        <div class="big-heart-container">
          <button class="big-heart" @click="replayBurst" aria-label="Replay hearts">💖</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Carousel from './components/Carousel.vue'

export default {
  name: 'App',
  components: { Carousel },
  data() {
    return {
      accepted: false,
      burstKey: 0,
    }
  },
  methods: {
    sayYes() {
      this.accepted = true
    },
    replayBurst() {
      this.burstKey++
    },
    heartStyle(n) {
      const left = Math.random() * 100
      const delay = Math.random() * 8
      const duration = 6 + Math.random() * 8
      const size = 10 + Math.random() * 25
      const opacity = 0.3 + Math.random() * 0.5
      return {
        left: `${left}%`,
        animationDelay: `${delay}s`,
        animationDuration: `${duration}s`,
        fontSize: `${size}px`,
        opacity: opacity,
      }
    },
    burstStyle(n) {
      const angle = (n / 50) * 360
      const distance = 100 + Math.random() * 400
      const x = Math.cos((angle * Math.PI) / 180) * distance
      const y = Math.sin((angle * Math.PI) / 180) * distance
      const size = 15 + Math.random() * 35
      const delay = Math.random() * 0.5
      return {
        '--x': `${x}px`,
        '--y': `${y}px`,
        fontSize: `${size}px`,
        animationDelay: `${delay}s`,
        left: '50%',
        top: '50%',
      }
    },
    randomHeart() {
      const hearts = ['❤️', '💖', '💕', '💗', '💘', '💝', '💓', '💞', '🩷', '♥️']
      return hearts[Math.floor(Math.random() * hearts.length)]
    },
  },
}
</script>

<style>
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  overflow-x: hidden;
}

.valentine-app {
  min-height: 100vh;
  background: linear-gradient(135deg, #fce4ec 0%, #f8bbd0 25%, #f48fb1 50%, #f06292 75%, #ec407a 100%);
  font-family: 'Quicksand', sans-serif;
  position: relative;
  overflow: hidden;
  transition: background 1s ease;
}

.valentine-app.said-yes {
  background: linear-gradient(135deg, #fce4ec 0%, #ffcdd2 30%, #ef9a9a 60%, #e57373 100%);
}

/* Floating Hearts */
.floating-hearts {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  pointer-events: none;
  z-index: 0;
}

.float-heart {
  position: absolute;
  top: 100%;
  color: #e91e63;
  animation: floatUp linear infinite;
}

@keyframes floatUp {
  0% {
    transform: translateY(0) rotate(0deg);
    opacity: 0;
  }
  10% {
    opacity: 1;
  }
  90% {
    opacity: 0.8;
  }
  100% {
    transform: translateY(-110vh) rotate(720deg);
    opacity: 0;
  }
}

/* Celebration */
.celebration-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  pointer-events: none;
  z-index: 100;
}

.burst-hearts {
  position: relative;
  width: 100%;
  height: 100%;
}

.burst-heart {
  position: absolute;
  animation: burst 2s ease-out forwards;
}

@keyframes burst {
  0% {
    transform: translate(0, 0) scale(0);
    opacity: 1;
  }
  50% {
    opacity: 1;
  }
  100% {
    transform: translate(var(--x), var(--y)) scale(1.5) rotate(360deg);
    opacity: 0;
  }
}

/* Content */
.content-wrapper {
  position: relative;
  z-index: 10;
  max-width: 700px;
  margin: 0 auto;
  padding: 40px 20px 60px;
  text-align: center;
}

.title {
  font-family: 'Dancing Script', cursive;
  font-size: 3rem;
  color: #880e4f;
  margin-bottom: 30px;
  text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1);
  animation: fadeInDown 1s ease;
}

.celebration-title {
  font-size: 3.2rem;
  animation: pulse 1.5s ease infinite, fadeInDown 0.8s ease;
}

@keyframes fadeInDown {
  from {
    opacity: 0;
    transform: translateY(-30px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

@keyframes pulse {
  0%, 100% {
    transform: scale(1);
  }
  50% {
    transform: scale(1.05);
  }
}

.heart-icon {
  display: inline-block;
  animation: heartBeat 1.2s ease infinite;
}

@keyframes heartBeat {
  0%, 100% {
    transform: scale(1);
  }
  25% {
    transform: scale(1.2);
  }
  40% {
    transform: scale(1);
  }
  60% {
    transform: scale(1.15);
  }
}

/* Question Section */
.question-section {
  margin-top: 40px;
}

.subtitle {
  font-family: 'Dancing Script', cursive;
  font-size: 1.6rem;
  color: #ad1457;
  margin-bottom: 30px;
}

.yes-btn {
  background: linear-gradient(135deg, #e91e63, #c2185b, #e91e63);
  background-size: 200% 200%;
  color: white;
  border: none;
  padding: 18px 55px;
  font-size: 1.8rem;
  font-family: 'Dancing Script', cursive;
  font-weight: 700;
  border-radius: 50px;
  cursor: pointer;
  transition: all 0.3s ease;
  box-shadow: 0 6px 25px rgba(233, 30, 99, 0.4);
  animation: gradientMove 3s ease infinite, bounceIn 0.8s ease;
  position: relative;
  overflow: hidden;
}

.yes-btn::before {
  content: '';
  position: absolute;
  top: -50%;
  left: -50%;
  width: 200%;
  height: 200%;
  background: radial-gradient(circle, rgba(255, 255, 255, 0.2) 0%, transparent 70%);
  animation: shimmer 3s ease infinite;
}

@keyframes shimmer {
  0%, 100% {
    transform: translate(-30%, -30%);
  }
  50% {
    transform: translate(30%, 30%);
  }
}

@keyframes gradientMove {
  0%, 100% {
    background-position: 0% 50%;
  }
  50% {
    background-position: 100% 50%;
  }
}

@keyframes bounceIn {
  0% {
    transform: scale(0);
  }
  50% {
    transform: scale(1.15);
  }
  70% {
    transform: scale(0.95);
  }
  100% {
    transform: scale(1);
  }
}

.yes-btn:hover {
  transform: scale(1.1);
  box-shadow: 0 10px 40px rgba(233, 30, 99, 0.6);
}

.yes-btn:active {
  transform: scale(0.95);
}

.btn-heart {
  display: inline-block;
  margin: 0 5px;
  animation: heartBeat 1s ease infinite;
}

/* Accepted Section */
.accepted-section {
  margin-top: 40px;
  animation: fadeInDown 0.8s ease;
}

.love-message {
  font-family: 'Dancing Script', cursive;
  font-size: 1.8rem;
  color: #880e4f;
  margin-bottom: 30px;
  line-height: 1.5;
}

.big-heart-container {
  display: flex;
  justify-content: center;
  margin-top: 20px;
}

.big-heart {
  font-size: 6rem;
  animation: heartBeat 1s ease infinite;
  filter: drop-shadow(0 0 20px rgba(233, 30, 99, 0.6));
  background: none;
  border: none;
  cursor: pointer;
  padding: 0;
  transition: transform 0.2s ease;
}

.big-heart:hover {
  transform: scale(1.2);
}

.big-heart:active {
  transform: scale(0.9);
}

/* Responsive */
@media (max-width: 600px) {
  .title {
    font-size: 2rem;
  }
  .subtitle {
    font-size: 1.2rem;
  }
  .yes-btn {
    padding: 14px 40px;
    font-size: 1.4rem;
  }
  .love-message {
    font-size: 1.3rem;
  }
}
</style>
