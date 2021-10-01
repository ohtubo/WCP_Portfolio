/*global $*/
// jquery書きはじめ
$(function (){
  // 処理（ページが読み込まれた時、フォームに残り何文字入力できるかを数えて表示する）

  //フォームに入力されている文字数を数える
  //フォームのidから値を取得
  var input = document.getElementById("scenario_title");
  
  if (input != null) {
    var count = input.value.length
    // var count = $(".js-text-title").text().replace(/\n/g, "改行").length;
    // console.log(count);
    //残りの入力できる文字数を計算
    var now_count = 30 - count;
    // console.log(now_count);
    //文字数がオーバーしていたら文字色を赤にする[静的な表示]
    if (count > 30) {
      $(".js-text-title-count").css("color","red");
    }
    //残りの入力できる文字数を表示
    $(".js-text-title-count").text( "残り" + now_count + "文字");
  
    $(".js-text-title").on("keyup", function() {
      // 処理（キーボードを押した時、フォームに残り何文字入力できるかを数えて表示する）
      //フォームのvalueの文字数を数えるる[動的な表示]
      var count = $(this).val().replace(/\n/g, "改行").length;
      var now_count = 30 - count;
  
      if (count > 30) {
        $(".js-text-title-count").css("color","red");
      } else {
        $(".js-text-title-count").css("color","black");
      }
      $(".js-text-title-count").text( "残り" + now_count + "文字");
    });
  }
});