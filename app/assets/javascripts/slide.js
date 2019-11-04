$(document).ready(function(){
  $('.slider-list').slick({
    autoplaySpeed: 5000,
    arrows: false,
    dots:true,
    autoplay:true,
    infinite: true,
    draggable: true,
    pauseOnHover: true,
    zIndex: 0,
  });
  $('.slider-prev').on('click',function(){
    $('.slider-list').slick('slickNext');
  });
  $('.slider-next').on('click',function(){
    $('.slider-list').slick('slickPrev');
  });
});