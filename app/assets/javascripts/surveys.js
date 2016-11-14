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

var showAnswerOnClick = function(){
	$(document).on('click', '.show-answer', function(){
		var id = $(this).attr('id').split("_")[1];
		$(this).hide();
		$("#hide_"+id).show();
		$("#feedback_"+id).toggle();
	});
};

var hideAnswerOnClick = function(){
	$(document).on('click', '.hide-answer', function(){
		var id = $(this).attr('id').split("_")[1];
		$(this).hide();
		$("#show_"+id).show();
		$("#feedback_"+id).toggle();
	});
};

multipleOnClick();
subjectiveOnClick();
showAnswerOnClick();
hideAnswerOnClick();