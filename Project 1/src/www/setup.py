#!/usr/bin/env python

print """
<html>
	<head>
		<link rel="stylesheet" href="css/main.css"/>
		<script src="js/jquery2-1.js"></script>
		<script src="js/main.js"></script>
		<script language="javascript" type="text/javascript" src="js/jquery.js"></script>
		<script language="javascript" type="text/javascript" src="js/jquery.flot.js"></script>
		
		<title>Reflow Oven Controller</title>
	</head>
	<body>
		<div id="container">
			<div id="setup">
			<h1>Reflow Oven Controller</h1>
			<div class="profile" id="profile1">Profile 1</div>
			<div class="profile" id="profile2">Profile 2</div>
			<div class="profile" id="profile3">Profile 3</div>
			
			<form method="get" action="reflow.py" id="setupForm">
				<div class="tooltip" title="Between 1 and 5 degrees">
				<input type="text" placeholder="Soak Rate" name="soakRate" maxlength="3"/>
				</div>
				
				<div class="tooltip" title="Between 100 and 200 degrees">
				<input type="text" placeholder="Soak Temp" name="soakTemp" maxlength="3"/>
				</div>
				
				<div class="tooltip" title="Between 80 and 120 seconds">
				<input type="text" placeholder="Soak Time" name="soakTime" maxlength="3"/>
				</div>
				
				<div class="tooltip" title="Between 1 and 5 degrees">
				<input type="text" placeholder="Reflow Rate" name="reflowRate" maxlength="3"/>
				</div>
				
				<div class="tooltip" title="Between 200 and 235 degrees">
				<input type="text" placeholder="Reflow Temp" name="reflowTemp" maxlength="3"/>
				</div>
				
				<div class="tooltip" title="Between 30 and 90 seconds">
				<input type="text" placeholder="Reflow Time" name="reflowTime" maxlength="3"/>
				</div>
				
				<div class="tooltip" title="Between 5 and 10 degrees">
				<input type="text" placeholder="Cooling Rate" name="coolingRate" maxlength="3"/>
				</div>
				
				<input type="submit" value="Start" id="submit" />
			</form>
			</div>
			
			<div id="graph">
				<div id="chart" style="width:750px; height:605px;"></div>
			</div>
		</div>
	</body>
</html>

"""

#Prevent file not existing crash
f = open('temp.json', 'w')
f.write('{"data": 20}')
f.close()