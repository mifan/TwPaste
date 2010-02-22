$(document).ready(function() {  
			//click
			$("#addDescId").click(function(){
				//$(this).blur();
				var textDesc = $("textDesc");
				if(textDesc){
					textDesc.slideToggle("fast");
					if(textDesc.visable()){
						  textDesc.text('+ Hide Description'); 
					}else{
						 textDesc.text('+ Add Description'); 
					}
				}

				return false;
			});

			$("#addTagsId").click(function(){
				//$(this).blur();
				var textTags = $("textTags");
				if(textTags){
					textTags.slideToggle("fast");
					if(textTags.visable()){
						  textTags.text('- Hide Tags'); 
					}else{
						 textTags.text('+ Add Tags'); 
					}
				}

				return false;
			});
});
