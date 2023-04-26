// prev,nextボタンなし、自動再生あり
$(function () {
  const swiper = new Swiper(".gallerySwiper", {

    // オプション設定

    // ループ
    loop: true,
    // 切り替えスピード(ミリ秒)
    speed: 300,
    // スライド方向
    direction: "horizontal",
    // スライド効果
    effect: "slide",

    // マージン指定
    spaceBetween: 40,
    // 一度に表示するスライドの数
    slidesPerView: 1.25,
    // 中央寄せ
    centeredSlides: true,

    // １スライドの表示数 (デフォルト = SP)
    slidesPerView: 1,
    // 768px以上(TB・PC)の場合は1スライドあたり2枚ずつ表示 (左右の2枚は半分ずつ = 計3枚)
    breakpoints: {
      768: {
        slidesPerView: 3,
      }
    },

    // 遅延読み込み
    lazy: {
      loadPrevNext: true,
      loadTransitionStart: true,
      loadPrevNextAmount: 2
    },

    // 自動再生
    autoplay: {
      delay: 4000,
    },
  });

  //画面に現れるまでswiperを停止
  swiper.autoplay.stop();
  $(window).on('scroll', function () {
    var position = $('.gallerySwiper').offset().top - $(window).innerHeight() + 100,
        scrollTop = $(window).scrollTop(); 

    if(scrollTop > position) {
      // 画面に現れたらswiperを開始
      swiper.autoplay.start();
    }else{
      // 画面外にスクロールしたらswiperを停止
      swiper.autoplay.stop();
    }
  });

  // 注文完了画面
  let ballAnimation = anime({
    targets: '.ball',
    translateY: {
      value: '-50vh',
      duration: 2000,
      delay: 0,
      easeing: 'easeInOutExpo'
    },
    rotateY: {
      value: '180deg',
      duration: 1000,
      delay: 500,
      easeing: 'easeOutBounce'
    },
    elasticity: 500,
    duration: 2000,
    // loop: true
  });
});