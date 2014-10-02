var _roost = _roost || [];
_roost.push(['appkey','98a85b848529445d93e5f17368b71a78']);
_roost.push(['autoprompt', false]);

$(function() {
  $('#subscribeButton').click(function(e) {
    e.preventDefault();

    if ($('#lunch').is(':checked') || $('#dinner').is(':checked')) {
      subs = [];
      _roost.prompt();
      _roost.push(["segments_clear"]);

      if ($('#lunch').is(':checked')) {
        subs.push("lunch");
        _roost.push(["segments_add", "lunch"]);
      }

      if($('#dinner').is(':checked')) {
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

      var replaceText =  "<p class=\"animated fadeInDown\">Thanks for subscribing. We'll notify you about "
                         + subsConcat + ".</p>";
      $('#subscription').replaceWith(replaceText);
    }
  });

  $('#updateButton').click(function(e) {
    e.preventDefault();

    if ($('#ios').is(':checked') || $('#android').is(':checked')) {
      var updates = [];

      if ($('#ios').is(':checked')) {
        updates.push("iOS");
        // subscribe ios
      }

      if ($('#android').is(':checked')) {
        updates.push("Android");
        // subscribe android
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
      $('#emailUpdate').replaceWith(replaceText);
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
