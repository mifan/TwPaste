$(document).ready(function() {  
  //click
  $("#theme_name").change(function(){
    var currentClasses = "highlight hl" + $(this).val();
    $(".highlight").attr("class",currentClasses);
    return false;
  });

});
