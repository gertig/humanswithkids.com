//jQuery plugin that serializes a form in Rails type params
$.fn.serializeObject = function() {
  var values = {}
  $("form input, form select, form textarea").each( function(){
    values[this.name] = $(this).val();
  });

  return values;
}


//DOM is Ready
$(function(){

  //PUSHDOWN MESSAGES
  if ($(".flashy").length) {
     $(".close_me").live("click", function(){
       $(this).hide();
       $("div#messages").hide();
     });
     $("div#messages").slideDown();
     $("div#messages").delay(5000).slideUp();
  }

  // CONTACT US TOOLTIP
  $('#email-me').tooltip();

  // Pin the Sidebar
  $(".pinned").pin({
      minWidth: 940,
      containerSelector: ".post-form-container"
      // containerSelector: "#post-sidebar"
  });

  // RESIZE TEXTAREA of Post Title when Editing
  $('textarea.post-input-title').autosize();
  $('textarea.ag-post-editing-field').autosize();


  // Only use Countable.js if you are editing/creating content
  if ($('#post_content').length || $('#tweet_body').length) {
    // COUNTABLE
    var countable_elem;

    console.log("LETS COUNT");

    if ($('#post_content').length) {
      countable_elem = document.getElementById("post_content");
    } else if ($('#tweet_body').length) {
      countable_elem = document.getElementById("tweet_body");
    }


    var results = {
          paragraphs: document.getElementById('result__paragraphs'),
          words: document.getElementById('result__words'),
          characters: document.getElementById('result__characters'),
          all: document.getElementById('result__all')
        };

    new Countable(countable_elem, countableUpdater);
  }

  function countableUpdater(counter) {
    if ('textContent' in document.body) {
      if (results.paragraphs) {
        results.paragraphs.textContent = counter.paragraphs;
        results.words.textContent = counter.words;
      }

      if (results.all) {
        results.all.textContent = counter.all;
      }

      // results.characters.textContent = counter.characters
      // results.all.textContent = counter.all
    } else {
      // results.paragraphs.innerText = counter.paragraphs;
      // results.words.innerText = counter.words;
      // results.characters.innerText = counter.characters
      // results.all.textContent = counter.all
    }
  };

  console.log("I'm ready");

  // BLUR via VAGUE
  // var vague = $("#blurred-logo-wrapper").Vague({
  //   intensity: 6 //blur intensity,
  //   // forceSVGUrl: false // force the absolute path to the svg filter
  // });

  // vague.blur();

  // $("#hero-image").on({
  //   click: function(){
  //     $(this).addClass("active");
  //   },
  //   mouseenter: function(){
  //     console.log("I need to add a con snippet");
  //     // $(this).addClass("inside");
  //     vague.unblur();
  //   },
  //   mouseleave: function(){
  //     // $(this).removeClass("inside");
  //     vague.blur();
  //   }
  // });

});
