// シナリオ投稿画面,編集画面の概要入力画面文字数カウント表示処理
/*global $*/
// jquery書きはじめ
$(function (){

  // 処理（ページが読み込まれた時、フォームに残り何文字入力できるかを数えて表示する）

  //フォームに入力されている文字数を数える
  //フォームのidから値を取得
  var input = document.getElementById("scenario_overview");

  if (input != null) {
  var count = input.value.length
  // console.log(count);
  //残りの入力できる文字数を計算
  var now_count = 250 - count;
  //文字数がオーバーしていたら文字色を赤にする
  if (count > 250) {
    $(".js-text-overview-count").css("color","red");
  }
  //残りの入力できる文字数を表示
  $(".js-text-overview-count").text( "残り" + now_count + "文字");

  $(".js-text-overview").on("keyup", function() {
    // 処理（キーボードを押した時、フォームに残り何文字入力できるかを数えて表示する）
    //フォームのvalueの文字数を数える
    var count = $(this).val().replace(/\n/g, "改行").length;
    var now_count = 250 - count;

    if (count > 250) {
      $(".js-text-overview-count").css("color","red");
    } else {
      $(".js-text-overview-count").css("color","black");
    }
    $(".js-text-overview-count").text( "残り" + now_count + "文字");
  });
  }
});