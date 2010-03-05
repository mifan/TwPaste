$(document).ready(function() {  
  //click
  $("#addDescId").click(function(){
    var textDesc = $("#textDesc");
    if(textDesc){
      textDesc.slideToggle("fast", function(){
        if(textDesc.is(":visible")){
          $("#addDescId").text('- Hide Description');
        }else{
          $("#addDescId").text('+ Add Description');
        }
      });
    }
    return false;
  });

  $("#addTagsId").click(function(){
    var textTags = $("#textTags");
    if(textTags){
      textTags.slideToggle("fast", function(){
        if(textTags.is(":visible")){
          $("#addTagsId").text('- Hide Tags');
        }else{
          $("#addTagsId").text('+ Add Tags');
        }
      });
    }
    return false;
  });

   $("#new_snippet").validate();


});