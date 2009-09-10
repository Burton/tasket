$(document).ready(function() {
  $("#show_tasked_input").click(function() {
    $("#tasked").show();
		$("#show_tasked_input").hide();
  });

	$(".complete_task").click(function() {
		var task_li = $(this).parent().parent();
		var action_link = $(this);
		var task_li_id = task_li.attr("id");
		var task_id = parseInt(task_li_id.replace('task_',''));
		$.post("/task/update", { id: task_id, status: 1 }, function(data) {
			action_link.parent().remove();
			task_li.animate({ backgroundColor: "#00FF55" }, 500);
		} );
	});
	$(".remove_task").click(function() {
		var task_li = $(this).parent().parent();
		var action_link = $(this);
		var task_li_id = task_li.attr("id");
		var task_id = parseInt(task_li_id.replace('task_',''));
		$.post("/task/update", { id: task_id, status: -1 }, function(data) {
			action_link.parent().remove();
			task_li.animate({ backgroundColor: "#FF0066" }, 500);
		} );
	});
	
});


// event listener on #tasked_email text-input to auto-populate option-list of valid users...
$(document).ready(function() {
	//$('#tasked_email').ready(function(){
		// foo
	//})
});