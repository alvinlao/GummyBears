//GLOBALS
var soakRate, soakTemp, soakTime, reflowRate, reflowTemp, reflowTime, coolingRate;

// CHART.JS
var roomTemp = 20;
var targetXAxis = [];
var targetYAxis = [];

function updateChart() {
	//Target temperature
	var target = {
					color: 'rgba(232,52,65,1)',
					data: [],
					points: {
						fill: true,
						fillColor: 'rgba(232,52,65,1)'
					}
				};
	
	var options = {
		series: {
			shadowSize: 0
		},
		lines: {
			show: true
		},
		points: {
			show: true
		},
		yaxis: {
			min: 0,
			max: 300
		},
		xaxis: {
			show: true
		}
	};
	
	for(var i = 0; i < targetXAxis.length; ++i) {
		target.data.push([targetXAxis[i], targetYAxis[i]]);
	}
	
	$.plot("#chart", [target], options);
}

function updateTargetChart() {
	getFields();
	
	targetXAxis[0] = 0;
	targetXAxis[1] = (soakRate === 0) ? 1 : (soakTemp-roomTemp)/soakRate;
	targetXAxis[2] = parseInt(targetXAxis[1]) + parseInt((soakTime === 0) ? 1 : soakTime);
	targetXAxis[3] = parseInt(targetXAxis[2]) + parseInt((reflowRate === 0) ? 1 : (reflowTemp - soakTemp)/reflowRate);
	targetXAxis[4] = parseInt(targetXAxis[3]) + parseInt(reflowTime);
	targetXAxis[5] = parseInt(targetXAxis[4]) + parseInt((reflowTemp - roomTemp)/coolingRate);
	
	targetYAxis[0] = roomTemp;
	targetYAxis[1] = soakTemp;
	targetYAxis[2] = soakTemp;
	targetYAxis[3] = reflowTemp;
	targetYAxis[4] = reflowTemp;
	targetYAxis[5] = roomTemp;
	
	for(var i = 0; i < targetXAxis.length; i++) {
		targetXAxis[i] = parseInt(targetXAxis[i].toFixed(2));
	}
	
	updateChart();
}


// ------------------------------------------------------------------------
// MAIN
// ------------------------------------------------------------------------		
$(function() {	
	$("#profile1").click(function() {
		$("#profile1").addClass("selected");
		$("#profile2").removeClass("selected");
		$("#profile3").removeClass("selected");
		
		var values = [1, 170, 100, 3, 230, 40, 6];
		updateFields(values);
		updateTargetChart();
	});
	
	$("#profile2").click(function() {
		$("#profile1").removeClass("selected");
		$("#profile2").addClass("selected");
		$("#profile3").removeClass("selected");
		
		var values = [1, 150, 100, 2, 220, 2, 2];
		updateFields(values);
		updateTargetChart();
	});
	
	$("#profile3").click(function() {
		$("#profile1").removeClass("selected");
		$("#profile2").removeClass("selected");
		$("#profile3").addClass("selected");
		
		var values = [1, 150, 100, 3, 220, 3, 3];
		updateFields(values);
		updateTargetChart();
	});
	
	//CHART STUFF
	
	//Bind input updates to chart update
	$("input[name=soakRate]").on('input', function() {
		updateTargetChart();
	});
	$("input[name=soakTemp]").on('input', function() {
		updateTargetChart();
	});
	$("input[name=soakTime]").on('input', function() {
		updateTargetChart();
	});
	$("input[name=reflowRate]").on('input', function() {
		updateTargetChart();
	});
	$("input[name=reflowTemp]").on('input', function() {
		updateTargetChart();
	});
	$("input[name=reflowTime]").on('input', function() {
		updateTargetChart();
	});
	$("input[name=coolingRate]").on('input', function() {
		updateTargetChart();
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

function getFields() {
	soakRate = parseInt($("input[name=soakRate]").val());
	soakTemp = parseInt($("input[name=soakTemp]").val());
	soakTime = parseInt($("input[name=soakTime]").val());
	reflowRate = parseInt($("input[name=reflowRate]").val());
	reflowTemp = parseInt($("input[name=reflowTemp]").val());
	reflowTime = parseInt($("input[name=reflowTime]").val());
	coolingRate = parseInt($("input[name=coolingRate]").val());
	
	if(soakRate == '' || isNaN(soakRate)) soakRate=0;
	if(soakTemp == '' || isNaN(soakTemp)) soakTemp=0;
	if(soakTime == '' || isNaN(soakTime)) soakTime=0;
	if(reflowRate == '' || isNaN(reflowRate)) reflowRate=0;
	if(reflowTemp == '' || isNaN(reflowTemp)) reflowTemp=0;
	if(reflowTime == '' || isNaN(reflowTime)) reflowTime=0;
	if(coolingRate == '' || isNaN(coolingRate)) coolingRate=0;
}
