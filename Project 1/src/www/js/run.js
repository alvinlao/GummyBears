// ------------------------------------------------------------------------
// MAIN
// ------------------------------------------------------------------------		
// REQUIRES:
// var soakRate, soakTemp, soakTime, reflowRate, reflowTemp, reflowTime, coolingRate;
// ------------------------------------------------------------------------		
/*
var soakRate = 3;
var soakTemp = 170;
var soakTime = 100;
var reflowRate = 3;
var reflowTemp = 230;
var reflowTime = 40;
var coolingRate = 6;
var roomTemp = 20;
*/

var roomTemp = 20;
$(function() {			
	$("#chart").hide();
	$("button.start").click(function () {
		$("#chart").show();
		$("#buttonContainer").hide();
		updateChart();
	});
});

function updateChart() {
	var iteration = 0;
	
	//Target temperature
	var target = {
					color: 'rgba(232,52,65,1)',
					data: [],
					points: {
						fill: true,
						fillColor: 'rgba(232,52,65,1)'
					}
				};
	
	//Real current temperature
	var real = {
				color: 'rgba(73,182,238,1)',
				data: [],
				points: {
					fill: true,
					fillColor: 'rgba(73,182,238,1)'
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
	
	function fetchData() {
		++iteration;
		
		//Only display 1 minute of data
		if(target.data.length === 60) {
			target.data.splice(0, 1);
		}
		target.data.push([iteration, getTargetTemperature(iteration)]);
		
		//Get real temperature
		$.ajax({
			url: 'getTemp.py',
			type: "GET",
			dataType: "json",
			async: false,
			success: function(temp) {
				if(real.data.length === 60) {
					real.data.splice(0, 1);
				}
				real.data.push([iteration, temp.data]);
			}
		});
		
		$.plot("#chart", [real, target], options);
		
		
		setTimeout(fetchData, 1000);
	}

	//Main update loop
	fetchData();
}

function getTargetTemperature(t) {
	var soakStart = (soakTemp-roomTemp)/soakRate;
	var soakEnd = soakStart + soakTime;
	var reflowPeak = soakEnd + ((reflowTemp - soakTemp)/reflowRate);
	var reflowEnd = reflowPeak + reflowTime;	
	var finish = reflowEnd + ((reflowTemp - roomTemp)/coolingRate);		// -1 *C/s
	
	//Preheat
	if(t <= soakStart) {
		return (soakRate*t + roomTemp);
	}
	
	//Soak
	if(t > soakStart && t <= soakEnd) {
		return (soakTemp);
	}
	
	//Reflow Heat
	if(t > soakEnd && t <= reflowPeak) {
		return (reflowRate*(t-soakEnd) + soakTemp);
	}
	
	//Reflow
	if(t > reflowPeak && t <= reflowEnd) {
		return (reflowTemp);
	}
	
	//Cool
	if(t > reflowEnd && t <= finish) {
		return (-1*coolingRate*(t-reflowEnd) + reflowTemp);
	}
	
	return roomTemp;
}