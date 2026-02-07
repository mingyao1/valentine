<template>
  <div class="carousel-container">
    <div class="carousel">
      <div class="carousel-inner" :style="carouselStyle">
        <div
          v-for="(photo, index) in photos"
          :key="index"
          class="carousel-slide"
        >
          <div class="photo-frame">
            <img :src="photo.src" :alt="photo.caption" class="photo" />
            <p class="caption">{{ photo.caption }}</p>
          </div>
        </div>
      </div>

      <!-- Nav Arrows -->
      <button class="nav-btn prev-btn" @click="prev" aria-label="Previous">
        ‹
      </button>
      <button class="nav-btn next-btn" @click="next" aria-label="Next">
        ›
      </button>

      <!-- Dots -->
      <div class="carousel-dots">
        <button
          v-for="(photo, index) in photos"
          :key="'dot-' + index"
          class="dot"
          :class="{ active: currentIndex === index }"
          @click="goTo(index)"
          :aria-label="'Go to slide ' + (index + 1)"
        ></button>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Carousel',
  data() {
    return {
      currentIndex: 0,
      autoplayTimer: null,
      /*
       * ✏️ HOW TO ADD YOUR PHOTOS:
       *
       * Option A – Local images:
       *   1. Create a folder:  app/public/photos/
       *   2. Drop your images there (e.g. pic1.jpg, pic2.jpg …)
       *   3. Reference them as:  src: '/photos/pic1.jpg'
       *
       * Option B – Online URLs:
       *   Just paste the full URL as the src value.
       *
       * Add as many objects as you like!
       */
      photos: [
        {
          src: import.meta.env.BASE_URL + 'photos/E6E0D78E-F98A-41B3-B29E-E5FD23674C30_1_105_c.jpeg',
          caption: '❤️',
        },
        {
          src: import.meta.env.BASE_URL + 'photos/4556FFC3-B2B8-4DBB-9286-B0110FA7F8E8_1_105_c.jpeg',
          caption: '💖',
        },
        {
          src: import.meta.env.BASE_URL + 'photos/9CF18577-E094-4895-ACD5-DC69915D6A3E_1_105_c.jpeg',
          caption: '💕',
        },
        {
          src: import.meta.env.BASE_URL + 'photos/BCCBC80A-F0C9-4323-8B79-4F4EA00AE38F_1_105_c.jpeg',
          caption: '🥰',
        },
        {
          src: import.meta.env.BASE_URL + 'photos/FBB48F87-28F7-43ED-8C4A-795FB5980151_1_105_c.jpeg',
          caption: '💗',
        },
      ],
    }
  },
  computed: {
    carouselStyle() {
      return {
        transform: `translateX(-${this.currentIndex * 100}%)`,
      }
    },
  },
  methods: {
    next() {
      this.currentIndex = (this.currentIndex + 1) % this.photos.length
      this.resetAutoplay()
    },
    prev() {
      this.currentIndex =
        (this.currentIndex - 1 + this.photos.length) % this.photos.length
      this.resetAutoplay()
    },
    goTo(index) {
      this.currentIndex = index
      this.resetAutoplay()
    },
    startAutoplay() {
      this.autoplayTimer = setInterval(() => {
        this.currentIndex = (this.currentIndex + 1) % this.photos.length
      }, 4000)
    },
    resetAutoplay() {
      clearInterval(this.autoplayTimer)
      this.startAutoplay()
    },
  },
  mounted() {
    this.startAutoplay()
  },
  beforeUnmount() {
    clearInterval(this.autoplayTimer)
  },
}
</script>

<style scoped>
.carousel-container {
  width: 100%;
  max-width: 520px;
  margin: 0 auto 10px;
  padding: 0 10px;
  box-sizing: border-box;
}

.carousel {
  position: relative;
  overflow: hidden;
  border-radius: 20px;
  box-shadow: 0 10px 40px rgba(136, 14, 79, 0.25);
  background: rgba(255, 255, 255, 0.15);
  backdrop-filter: blur(10px);
}

.carousel-inner {
  display: flex;
  transition: transform 0.6s cubic-bezier(0.25, 0.46, 0.45, 0.94);
  will-change: transform;
}

.carousel-slide {
  width: 100%;
  min-width: 100%;
  flex-shrink: 0;
  box-sizing: border-box;
}

.photo-frame {
  padding: 12px;
  box-sizing: border-box;
}

.photo {
  width: 100%;
  aspect-ratio: 1 / 1;
  object-fit: cover;
  object-position: center;
  display: block;
  border-radius: 14px;
}

.caption {
  font-family: 'Dancing Script', cursive;
  font-size: 1.4rem;
  color: #880e4f;
  margin-top: 12px;
  text-align: center;
}

/* Navigation Buttons */
.nav-btn {
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
  background: rgba(255, 255, 255, 0.85);
  border: none;
  width: 40px;
  height: 40px;
  border-radius: 50%;
  font-size: 1.6rem;
  color: #c2185b;
  cursor: pointer;
  transition: all 0.3s ease;
  display: flex;
  align-items: center;
  justify-content: center;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
  z-index: 5;
  line-height: 1;
}

.nav-btn:hover {
  background: white;
  transform: translateY(-50%) scale(1.1);
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
}

.prev-btn {
  left: 10px;
}

.next-btn {
  right: 10px;
}

/* Dots */
.carousel-dots {
  display: flex;
  justify-content: center;
  gap: 8px;
  padding: 12px 0 18px;
}

.dot {
  width: 10px;
  height: 10px;
  border-radius: 50%;
  border: 2px solid #c2185b;
  background: transparent;
  cursor: pointer;
  transition: all 0.3s ease;
  padding: 0;
}

.dot.active {
  background: #e91e63;
  transform: scale(1.25);
  box-shadow: 0 0 8px rgba(233, 30, 99, 0.5);
}

.dot:hover {
  background: #f48fb1;
}

/* Responsive */
@media (max-width: 600px) {
  .carousel-container {
    max-width: 100%;
    padding: 0 8px;
  }

  .photo-frame {
    padding: 8px;
  }

  .caption {
    font-size: 1.1rem;
  }

  .nav-btn {
    width: 34px;
    height: 34px;
    font-size: 1.3rem;
  }
}
</style>
