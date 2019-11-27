$(window).on("turbolinks:load",function(){
  $('.uuoo').find('#0').removeClass("hidden")
  $('.uuoo').find('#0').addClass("active")
  if(document.URL.match("items/[0-9]+")){
    $('.a_small_image').on('click',function(){
      $('.active').addClass("hidden")
      $('.active').removeClass("active")
      var index_num = $(this).attr("id");
      var show_image = $('.uuoo').find("#"+index_num);
      show_image.removeClass("hidden")
      show_image.addClass("active")
    });
  };
});