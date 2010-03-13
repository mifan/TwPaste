$(document).ready(function() {  
  //click
  var textDesc = $("#textDesc");
  var textTags = $("#textTags");
  if(textDesc.is(":visible")){
          $("#addDescId").text('- Description');
        }else{
          $("#addDescId").text('+ Description');
   }
   if(textTags.is(":visible")){
          $("#addTagsId").text('- Tags');
        }else{
          $("#addTagsId").text('+ Tags');
   }



  $("#addDescId").click(function(){
      textDesc.toggle("fast", function(){
        if(textDesc.is(":visible")){
          $("#addDescId").text('- Description');
        }else{
          $("#addDescId").text('+ Description');
        }
      });
    return false;
  });

  $("#addTagsId").click(function(){
      textTags.toggle("fast", function(){
        if(textTags.is(":visible")){
          $("#addTagsId").text('- Tags');
        }else{
          $("#addTagsId").text('+ Tags');
        }
      });
    return false;
  });

  $("#new_paste").validate();


});
