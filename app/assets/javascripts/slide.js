jQuery(document).ready(function(){
  jQuery('.slider-list').slick({
    autoplaySpeed: 3000,
    dots:true,
    autoplay:true,
    infinite: true,
    draggable: true,
    accessibility: true,
    pauseOnHover: true,
    zIndex: 0
  });
  // var $slider_container = $('.slider-container'),
  //     $slider = $('.slider');

// $slider.slick({
//   appendArrows: $slider_container,
//   prevArrow: '.slider-arrow.slider-prev fa-icon angle-left',
//   nextArrow: '.slider-arrow.slider-next i-con angle-right',
// });
});