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
        type: 'POST',
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
        $('#md-textarea').removeClass('is-disabled');
        $('#preview-area').addClass('is-disabled');
        })
      .fail(function() {
        alert('failed for markdown preview');
      })
    })

// タブ表示操作---------------------------------------------------------------------------------

  // 記入欄ボタンが押されたらイベント発火
    $(document).on('click','#markdown', function() {
      $('#md-textarea').parent().css('display', '');
      //　.empty();　前の入力を空にする
      $('#preview-area').empty();
      $('#sample').removeClass('disabled');
      $('#preview').removeClass('disabled');
      $('#markdown').addClass('disabled');

      $('#preview-area').removeClass('is-disabled');
      $('#md-textarea').addClass('is-disabled');
      $('#sample-area').removeClass("is-disabled");
      console.log('here#markdown')
    });

  // プレビューボタン押されたらイベント発火
    $(document).on('click','#preview', function() {
      console.log('here#preview')
       $('#preview').addClass('disabled');
       $('#markdown').removeClass('disabled');
       $('#sample').removeClass('disabled');

       $('#preview-area').addClass("is-disabled");
       $('#sample-area').removeClass("is-disabled");
       $('#md-textarea').parent().css('display', 'none');
    });

  // 見本ボタンが押されたらイベント発火
    $(document).on('click','#sample', function() {
      console.log('here#sample')
        $('#sample').addClass('disabled');
        $('#markdown').removeClass('disabled');
        $('#preview').removeClass('disabled');

        $('#sample-area').addClass("is-disabled");
        $('#md-textarea').removeClass('is-disabled');
        $('#preview-area').removeClass('is-disabled');
        $('#md-textarea').parent().css('display', 'none');
        $('#preview-area').empty();
    });


  })

// 上記の動きをページが読み込まれたらすぐに動かす
  $(window).on('load', function () {
      $('.tab li:first-of-type').addClass("disabled"); //最初のliにactiveクラスを追加
      $('.area:first-of-type').addClass("is-disabled"); //最初の.areaにis-activeクラスを追加
    console.log("tab_load");
  });