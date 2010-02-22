$(document).ready(function() {  
            //click
            $("#addDescId").click(function(){
                //$(this).blur();
                var textDesc = $("#textDesc");
                if(textDesc){
                    textDesc.slideToggle("fast");
                    if(textDesc.is(":hidden")){
                         textDesc.text('+ Add Description');
                         textDesc.blue();
                    }else{
                        textDesc.text('+ Hide Description');
                        textDesc.focus();
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
                         textTags.text('+ Add Description');
                         textTags.blue();
                    }else{
                        textTags.text('+ Hide Description');
                        textTags.focus();
                    }
                }
                return false;
            });
});
