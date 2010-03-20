function comment_changed(){
  var commentLength = $('#comment_comment').val().length;
  var showChars = 120 - commentLength ;
  $('#commentChars').text(showChars);
  if(showChars > 0){
    $('#commentWarning').hide();
    $('#commentChars').removeClass('error');
  }else{
    $('#commentWarning').show();
    $('#commentChars').addClass('error');
  }
}

$(document).ready(function(){

  if(privatePaste){
	$('#commentAll').hide();
	$("#comment_post_to_twitter").attr("disabled","true");
  }

  $("#comment_comment").keyup(function(){
    comment_changed();
  });



  $("#comment_post_to_twitter").change(function(){
    if($(this)[0].checked){
      $('#commentAll').show();
    }else{
      $('#commentAll').hide();
    }  
  });

  $("#new_comment").validate({
    rules: {
      'comment[comment]': 'required'
    },
    messages: {
      'comment[comment]': 'Please enter your comment'
    }
  });

  $("#new_comment").submit(function(){
     $.post(
		 commentPostUrl,
		 $("#new_comment").serialize() ,
		 function(partional){
		  $("#comments").append(partional);
		  $("#comment_comment").val('');
	     });
	  return false;
  });
});
