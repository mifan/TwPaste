$(document).ready(function() {
  var textDesc = $("#textDesc");
  var textTags = $("#textTags");

  function checkPasteTitle(){
    if($("#paste_title").val().length > 0){
      $("#title-notice").hide();
      $("#paste_post_to_twitter").removeAttr("disabled");
      $("#paste_post_to_twitter").attr("checked",'true');

    }else{
      $("#title-notice").show();
      $("#paste_post_to_twitter").attr("disabled",'true');
      $("#paste_post_to_twitter").removeAttr("checked");
    }
  }

  checkPasteTitle();

  if($("#paste_desc").val().length > 0){
    textDesc.show();
  }

  if($("#paste_tag_list").val().length > 0){
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


  $("#paste_title").keyup(function(){
    checkPasteTitle();
  });

  $("#paste_title").change(function(){
    checkPasteTitle();
  });



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

  $("#paste_private").change(function(){
    if($(this)[0].checked){
      $("#paste_post_to_twitter").removeAttr("checked");
	  $("#paste_post_to_twitter").attr("disabled",'true');
    }else{
      $("#paste_post_to_twitter").removeAttr("disabled");
    }
  });


});
