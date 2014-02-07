// ------------------------------------------------------------------------
// MAIN
// ------------------------------------------------------------------------		
$(function() {	
	$("#profile1").click(function() {
		$("#profile1").addClass("selected");
		$("#profile2").removeClass("selected");
		$("#profile3").removeClass("selected");
		
		var values = [3, 170, 100, 3, 230, 40, 6];
		updateFields(values);
	});
	
	$("#profile2").click(function() {
		$("#profile1").removeClass("selected");
		$("#profile2").addClass("selected");
		$("#profile3").removeClass("selected");
		
		var values = [2, 150, 100, 2, 220, 2, 2];
		updateFields(values);
	});
	
	$("#profile3").click(function() {
		$("#profile1").removeClass("selected");
		$("#profile2").removeClass("selected");
		$("#profile3").addClass("selected");
		
		var values = [3, 150, 100, 3, 220, 3, 3];
		updateFields(values);
	});
});

function updateFields(vals) {
	$("input[name=soakRate]").val(vals[0]);
	$("input[name=soakTemp]").val(vals[1]);
	$("input[name=soakTime]").val(vals[2]);
	$("input[name=reflowRate]").val(vals[3]);
	$("input[name=reflowTemp]").val(vals[4]);
	$("input[name=reflowTime]").val(vals[5]);
	$("input[name=coolingRate]").val(vals[6]);
}
