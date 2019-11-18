$(document).on('turbolinks:load', function(){

  var add_list = $(".tesuuryou");
  function addprice(tesuuryou) {

    var html = `<div>
                 <p>¥${ tesuuryou.toLocaleString() }</p>
                </div>`
     add_list.append(html);
  }

  var add_list2 = $(".rieki");
  function addprice2(rieki) {

    var html2 = `<div>
                 <p>¥${ rieki.toLocaleString() }</p>
                </div>`
     add_list2.append(html2);
  }




$('#kakaku-kakumasu').on('keyup',function(e){
  e.preventDefault();
  var price = $('#kakaku-kakumasu').val(); 
  if(price.length == 0|| price <=300 || price >= 9999999){
    $(".tesuuryou").empty();
    $(".rieki").empty();
    var tesuuryou = '-'
    var rieki = '-'
     return;
   }
   $(".tesuuryou").empty();
   $(".rieki").empty();
   var tesuuryou = price/10;
   addprice(tesuuryou);  
   var rieki = price - tesuuryou;
   addprice2(rieki);



});


});