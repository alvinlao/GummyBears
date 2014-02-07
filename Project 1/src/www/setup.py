#!/usr/bin/env python

print """
<html>
	<head>
            <title>Reflow Oven</title>
		<link rel="stylesheet" href="css/main.css"/>
	</head>
	<body>
		<h1>Reflow Oven Controller</h1>

		<form method="get" action="reflow.py" id="setupForm">
			<input type="text" placeholder="Soak Rate" name="soakRate" />
			<input type="text" placeholder="Soak Temp" name="soakTemp" />
			<input type="text" placeholder="Soak Time" name="soakTime" />
			<input type="text" placeholder="Reflow Rate" name="reflowRate" />
			<input type="text" placeholder="Reflow Temp" name="reflowTemp" />
			<input type="text" placeholder="Reflow Time" name="reflowTime" />
			<input type="text" placeholder="Cooling Rate" name="coolingRate" />
			<input type="submit" value="Start" id="submit" />
		</form>
	</body>
</html>
"""