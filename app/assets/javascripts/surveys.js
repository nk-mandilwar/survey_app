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

multipleOnClick();
subjectiveOnClick();

