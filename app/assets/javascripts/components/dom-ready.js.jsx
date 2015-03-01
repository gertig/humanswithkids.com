/** @jsx React.DOM */

//DOM is Ready
$(function(){
// $(document).on("page:change", function() {
  console.log("Kick off React!");

  var $content = $("#comments-content");
  if ($content.length > 0) {
    React.renderComponent(
      <CommentBox url="comments.json" pollInterval={2000} />,
      document.getElementById('comments-content')
    );
  }
})
