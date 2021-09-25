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
      $('#preview-area').empty();
      $('#preview').removeClass('disabled');
      $('#markdown').addClass('disabled');
    })
  })