$(document).ready(function() {
  $("#show_tasked_input").click(function() {
    $("#tasked").show();
		$("#show_tasked_input").hide();
  });

	$(".complete_task").click(function() {
		var task_li = $(this).parent();
		var action_link = $(this);
		var task_li_id = task_li.attr("id");
		var task_id = parseInt(task_li_id.replace('task_',''));
		//alert(task_id);
		$.post("/task/update", { id: task_id, status: 1 }, function(data) {
			action_link.html("foo");
		}, "json" );
		// $.post("/task/update", { "id": task_id, "status": 1 }, function(data) {
		// 		// $.post("/task/update", {id: task_id, status: 1}, function(data) {
		//        action_link.html(
		//          "foo"
		//        );
		//      }, "json");
	});
	$("#remove_task").click(function() {
		var task_li = $(this).parent();
		var action_link = $(this);
		var task_li_id = task_li.attr("id");
		var task_id = parseInt(task_li_id.replace('task_',''));
		$.post("/task/update", {task: {status: -1}}, function(data) {
       action_link.html(
         "foo"
       );
     }, "json");
	});
	
});