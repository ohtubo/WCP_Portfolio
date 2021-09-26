//任意のタブにURLからリンクするための設定
function GethashID (hashIDName){
  if(hashIDName){
    //タブ設定
    $('.tab li').find('a').each(function() { //タブ内のaタグ全てを取得
      var idName = $(this).attr('href'); //タブ内のaタグのリンク名（例）#lunchの値を取得
      console.log("function--------");
      console.log(idName);
      console.log(hashIDName);
      if(idName == hashIDName){ //リンク元の指定されたURLのハッシュタグ（例）http://example.com/#lunch←この#の値とタブ内のリンク名（例）#lunchが同じかをチェック
        var parentElm = $(this).parent(); //タブ内のaタグの親要素（li）を取得
        $('.tab li').removeClass("active"); //タブ内のliについているactiveクラスを取り除き
        $(parentElm).addClass("active"); //リンク元の指定されたURLのハッシュタグとタブ内のリンク名が同じであれば、liにactiveクラスを追加
        console.log('active');
        //表示させるエリア設定
        $(".area").removeClass("is-active"); //もともとついているis-activeクラスを取り除き
        $(hashIDName).addClass("is-active"); //表示させたいエリアのタブリンク名をクリックしたら、表示エリアにis-activeクラスを追加
        console.log('is-active');
      }
    });
  }
}

//タブをクリックしたら
//ターボリンクスの影響で一回消えてるドキュメントを消す
//documentで再読み込みで「.tab a」を見つける
$(document).on('click','.tab a', function() {
  var idName = $(this).attr('href'); //タブ内のリンク名を取得
  console.log("tab_click");
  // if(idName == "#preview"){
  //   console.log("tab_preview_click");

  //   var text = $('#md-textarea').val();
  //   if (text == "") {
  //     return;
  //   }
  //   $.ajax({
  //     url: '/api/articles/preview',
  //     type: 'GET',
  //     dataType: 'json',
  //     data: { body: text }
  //   })

  //   GethashID (idName);//設定したタブの読み込みと
  //   return false;//aタグを無効にする
  // }
  GethashID (idName);//設定したタブの読み込みと
  return false;//aタグを無効にする
});


// // 上記の動きをページが読み込まれたらすぐに動かす
// $(window).on('load', function () {
//     $('.tab li:first-of-type').addClass("active"); //最初のliにactiveクラスを追加
//     $('.tab li:first-of-type').addClass("disabled"); //最初のliにactiveクラスを追加
//     $('.area:first-of-type').addClass("is-disabled"); //最初の.areaにis-activeクラスを追加
//   var hashName = location.hash; //リンク元の指定されたURLのハッシュタグを取得
//   console.log("tab_load");
//   GethashID (hashName);//設定したタブの読み込み
// });