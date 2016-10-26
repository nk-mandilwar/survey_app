var multipleOnClick = function(){
	$(document).on('click', '.multiple', function(){
		$(this).parent().next().next().find('.option-link').show();
	});
};

var subjectiveOnClick = function(){
	$(document).on('click', '.subjective', function(){
		$(this).parent().next().next().find('.remove_fields').trigger('click');
		$(this).parent().next().next().find('.option-link').hide();
	});
};

var subjectiveChecked = function(){
	var subjective = $('.subjective');
	for (var i = 0; i < subjective.length; ++i){
		if($(subjective[i]).prop('checked')){
			$(subjective[i]).parent().next().next().find('.option-link').hide();
		}	
		else{
			$(subjective[i]).parent().next().next().find('.option-link').show();
		}
	}			
};

multipleOnClick();
subjectiveOnClick();

