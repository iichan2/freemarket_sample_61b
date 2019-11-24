var images = [];
var inputs = [];
var image_attaced_counts = 0;
//items#editの場合のみ発火 documentではiichanbox表示前発火になりエラー
$(window).on("turbolinks:load",function(){
  if(document.URL.match("items/[0-9]+/edit")){
    //既存の画像の数を取得し、制御カウントを増やす
    var already_exist_imgs_number = $('.iichan_box').length
    image_attaced_counts = image_attaced_counts + already_exist_imgs_number
    //制御カウントに既存のラベルを合わせる
    var for_attribute = "upload-image" + image_attaced_counts
    $('label').attr('for', for_attribute)
    //追加用ラベルの追加
    var label = $(` <label for="upload-image${image_attaced_counts}">
                    <div class='sell_upload__area'>
                      <input class="upload-image" name=item[images_attributes][${image_attaced_counts}][image_url] data-countNumber=${image_attaced_counts} id="upload-image${image_attaced_counts}" type="file" >
                    </div>
                  </label>`);
    if($('.iichan_box').length >= 5 ){
      $('.dropzone-area2').prepend(label);
    }else{
      $('.dropzone-area').prepend(label);
    };
  };
});

$(document).on('change', 'input[type= "file"].upload-image',function() {
  //画像を保存する２段目inputタグ用ラベルの作成
  var label = $(` <label for="upload-image${image_attaced_counts}">
                  <div class='sell_upload__area'>
                  </div>
                </label>`);
  if($('.iichan_box').length === 4 ){
    $('.dropzone-area2').prepend(label);
  };
  //inputタグに配列形式で保存されているデータ群＝this 
  //multiple ='true'でなくても配列保存
  var file = $(this).prop('files')[0];
  //inputタグおよび中身をinputsに配列保存
  inputs.push($(this));
  //画像挿入のためのimgタグの作成
  var img = $(` <div class = "iichan_box">
                  <img data-countNumber=${image_attaced_counts}>
                  <div class="btn_wrapper">
                    <div class="xxxxxbtn delete">
                      削 除  
                    </div>
                  </div>
                </div>`);
  //JSでファイルを読み込む空間を作る
  var reader = new FileReader();
  //読み込み空間ができたら、発火 eventにFileReaderの値が入り、resultにDataURLが入る
  reader.onload = function(event) {
    img.find('img').attr({
      src: event.target.result,
      width: '120px'
    });
  };
  //読み込み空間でファイル取得
  reader.readAsDataURL(file);
  //images配列にimgタグらを保存
  images.push(img);
  //imagesの一番最後にある最新のimgを入力する
  var add_image = images.slice(-1);
  if($('.iichan_box').length < 5){
        var img_insert_target = $('#exhibit-images-preview');
      }else{
        var img_insert_target = $('#exhibit-images-preview2');
  };
  img_insert_target.append(add_image);
  //保存カウントを増やす
  image_attaced_counts = image_attaced_counts + 1
  //次の画像保存用のinputタグを挿入
  var new_image = $(`<input class="upload-image" name=item[images_attributes][${image_attaced_counts}][image_url] data-countNumber=${image_attaced_counts} id="upload-image${image_attaced_counts}" type="file" >`);
  $('.sell_upload__area').append(new_image);
  //ストップ解除
  $('input[type="submit"]').removeAttr("disabled")
  //ラベルのforのidのズレを合わせる
  var for_attribute = "upload-image" + image_attaced_counts
  $('label').attr('for', for_attribute)
});

//削除ギミック
$(document).on('click', '.delete', function() {
  //削除のdivがthis
  var delete_target_image = $(this).parent().parent();
  var delete_target_input_number = delete_target_image.children('img').attr('data-countNumber')
  //iichanbox以下を削除
  delete_target_image.remove();
  //inputs・images配列内部の値をnullに
  inputs[delete_target_input_number] = null
  images[delete_target_input_number] = null
  // iichanboxの数が５以下の場合第2ラベル削除、第1ラベル挿入
  var label = $(` <label for="upload-image${image_attaced_counts}">
                    <div class='sell_upload__area'>
                    </div>
                  </label>`);
  if($('.iichan_box').length === 4){
    $('label').remove();
    $('.dropzone-area').prepend(label);
  };
  //該当インプットタグを削除し、画像が０の場合はdata とnameを0にセットする
  $(`input[data-countNumber=${delete_target_input_number}]`).remove();
  if($(".iichan_box").length == 0) {
    var const_image = $(`<input class="upload-image" name=item[images_attributes]["${image_attaced_counts}"][image_url] data-countNumber=${image_attaced_counts} id="upload-image" type="file" >`);
    $('.sell_upload__area').append(const_image)  
  };
});

//deletedの方の削除メソッド
$(document).on('click', '.deleted', function() { 
  $(this).parent().parent().remove();
  let index = $(this).data("countnumber");
  $(`.js-destroy[data-countnumber="${index}"]`).attr("checked", "checked");
});

$(document).on("turbolinks:load",function(){
  //画像なしでsubmitした場合のストップ
  $("form[id=new_item]").on('submit',function(event){
    if($('.iichan_box').length == 0){
      event.preventDefault();
      alert("最低１枚は画像をアップロードしてください");
    };
  });
  //同上のギミックだがeditとnewでformのidが異なるため記載。
  if(document.URL.match("items/[0-9]+/edit")){
    $("form").on('submit',function(event){
      if($('.iichan_box').length == 0){
        event.preventDefault();
        alert("最低１枚は画像をアップロードしてください");
      };  
    });
  };
  //11枚以上の画像登録しようとする場合のストップ
  $("form").on('submit',function(event){
    if($('.iichan_box').length > 10){
      event.preventDefault();
      alert("画像枚数の上限は10枚です");
    };  
  });
});