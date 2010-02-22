$(document).ready(function() {  
			//click
			$("#addDescId").click(function(){
				//$(this).blur();
				var textDesc = $("#textDesc");
				if(textDesc){
					textDesc.slideToggle("fast");
					if(textDesc.visable()){
						textDesc.text('+ Hide Description');
						textDesc.focus();
					}else{
						 textDesc.text('+ Add Description');
						 textDesc.blue();
					}
				}

				return false;
			});

			$("#addTagsId").click(function(){
				//$(this).blur();
				var textTags = $("#textTags");
				if(textTags){
					textTags.slideToggle("fast");
					if(textTags.visable()){
						  textTags.text('- Hide Tags'); 
						  textTags.focus();
					}else{
						 textTags.text('+ Add Tags');
						 textTags.blur();
					}
				}

				return false;
			});
});
