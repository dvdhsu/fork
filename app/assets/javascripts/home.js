var _roost = _roost || [];
_roost.push(['appkey','98a85b848529445d93e5f17368b71a78']);
_roost.push(['autoprompt', false]);

function checked(id) {
  return $('#' + id).is(':checked');
}

$(function() {
  $('a[href*=#]').click(function(event){
        $('html, body').animate({
                  scrollTop: $( $.attr(this, 'href') ).offset().top
              }, 500);
            event.preventDefault();
  });

  $('#subscribeButton').click(function(e) {
    e.preventDefault();

    if (checked('lunch') || checked('dinner')) {
      subs = [];
      _roost.prompt();
      _roost.push(["segments_clear"]);

      if (checked('lunch')) {
        subs.push("lunch");
        _roost.push(["segments_add", "lunch"]);
      }

      if (checked('dinner')) {
        subs.push("dinner");
        _roost.push(["segments_add", "dinner"]);
      }

      // reflect changes
      if (subs.length == 1) {
        var subsConcat = subs[0];
      }
      else {
        var subsConcat = subs[0] + " and " + subs[1];
      }

      var replaceText =  "<div class=\"animated fadeInDown\"><p>Thanks for subscribing. We'll notify you about "
                         + subsConcat 
                         + ".</p> <p>If this is your first time, you'll need to approve when Safari asks to send you push notifications. That'll happen in a few seconds.</p></div>";
      $('#subscription').replaceWith(replaceText);
    }
  });

  $('#updatesSubscribe').on('ajax:success', function(xhr, status, error) {
    if (checked('ios') || checked('android')) {
      var updates = [];

      if (checked('ios')) {
        updates.push('iOS');
      }

      if (checked('android')) {
        updates.push('Android');
      }

      // reflect changes
      if (updates.length == 1) {
        var updatesConcat = updates[0];
      }
      else {
        var updatesConcat = updates[0] + " and " + updates[1];
      }

      var replaceText =  "<p class=\"animated fadeInDown\">Thanks. We'll let you know when we launch on "
                         + updatesConcat + ".</p>";
      $('#updatesSubscribe').replaceWith(replaceText);
    }
  });

  // retina display
  if(window.devicePixelRatio >= 1.2){
    $("[data-2x]").each(function(){
      if(this.tagName == "IMG"){
        $(this).attr("src",$(this).attr("data-2x"));
      } else {
        $(this).css({"background-image":"url("+$(this).attr("data-2x")+")"});
      }
    });
  }
});
