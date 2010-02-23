$(document).ready(function() {  
  //click
  $("#addDescId").click(function(){
    //$(this).blur();
    var textDesc = $("#textDesc");
    if(textDesc){
      textDesc.slideToggle("fast");
      if(textDesc.is(":hidden")){
        $("#addDescId").text('+ Add Description');
      }else{
        $("#addDescId").text('- Hide Description');
      }
    }
    return false;
  });

  $("#addTagsId").click(function(){
    //$(this).blur();
    var textTags = $("#textTags");
      if(textTags){
        textTags.slideToggle("fast");
        if(textTags.is(":hidden")){
          $("#addTagsId").text('+ Add Tags');
        }else{
          $("#addTagsId").text('- Hide Tags');
        }
      }
    return false;
  });

});
