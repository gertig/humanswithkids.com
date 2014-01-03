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


  // Only use Countable.js if you are editing/creating content
  if ($('#post_content').length) {
    // COUNTABLE
    var countable_elem = document.getElementById("post_content"),
        results = {
          paragraphs: document.getElementById('result__paragraphs'),
          words: document.getElementById('result__words'),
          characters: document.getElementById('result__characters'),
          all: document.getElementById('result__all')
        };
        
    new Countable(countable_elem, countableUpdater);
  }

  function countableUpdater(counter) {
    if ('textContent' in document.body) {
      results.paragraphs.textContent = counter.paragraphs;
      results.words.textContent = counter.words;
      // results.characters.textContent = counter.characters
      // results.all.textContent = counter.all
    } else {
      results.paragraphs.innerText = counter.paragraphs;
      results.words.innerText = counter.words;
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
