    /*global $*/
    $(function() {

    // previewボタンが押されたらイベント発火
    $('#preview').on('click', function() {
      console.log('preview');
      var text = $('#md-textarea').val();
      if (text == "") {
        return;
      }
      $.ajax({
        url: '/api/articles/preview',
        type: 'GET',
        dataType: 'json',
        data: { content: text }
      })
      .done(function(html) {
        // ajax成功したら、テキストエリアを非表示にする。
        $('#md-textarea').parent().css('display', 'none');
        // .append ()の内容を描画する。
        $('#preview-area').append(html.content);
        // markdownボタンとpreviewボタンのdisabledを入れ替える。
        $('#markdown').removeClass('disabled');
        $('#preview').addClass('disabled');
      })
      .fail(function() {
        alert('failed for markdown preview');
      })
    })

    // markdownボタンが押されたらイベント発火
    $('#markdown').on('click', function() {
      $('#md-textarea').parent().css('display', '');
      //　.empty();　前の入力を空にする
      $('#preview-area').empty();
      $('#preview').removeClass('disabled');
      $('#markdown').addClass('disabled');
    })

// タブ表示操作---------------------------------------------------------------------------------
    $(document).on('click','#sample', function() {
      console.log('here#sample')
       $('#sample').addClass('disabled');
       $('#markdown').removeClass('disabled');
       $('#preview').removeClass('disabled');

       $('#sample-area').addClass("is-disabled");
       $('#md-textarea').parent().css('display', 'none');
       $('#preview-area').empty();
    });

    $(document).on('click','#markdown', function() {
      console.log('here#markdown')
      $('#sample').removeClass('disabled');

      $('#md-textarea').parent().css('display', '');
      $('#preview-area').removeClass("is-disabled");
      $('#sample-area').removeClass("is-disabled");
    });

    $(document).on('click','#preview', function() {
      console.log('here#preview')
       $('#preview').addClass('disabled');
       $('#markdown').removeClass('disabled');
       $('#sample').removeClass('disabled');

       $('#preview-area').addClass("is-disabled");
       $('#sample-area').removeClass("is-disabled");
       $('#md-textarea').parent().css('display', 'none');
    });

  })

  // 上記の動きをページが読み込まれたらすぐに動かす
$(window).on('load', function () {
    $('.tab li:first-of-type').addClass("disabled"); //最初のliにactiveクラスを追加
    $('.area:first-of-type').addClass("is-disabled"); //最初の.areaにis-activeクラスを追加
  console.log("tab_load");
});