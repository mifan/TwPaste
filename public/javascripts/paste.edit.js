$(document).ready(function() {
  var textDesc = $("#textDesc");
  var textTags = $("#textTags");

  if(textDesc.val().length > 0){
    textDesc.show();
  }

  if(textTags.val().length > 0){
    textTags.show();
  }

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

  $("#new_paste").validate({
    rules: {
      'paste[code]': 'required'
    },
    messages: {
      'paste[code]': 'Please enter your source code or plain text'
    }
  });

});
