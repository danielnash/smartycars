{nocache}
<!DOCTYPE html>
<html>
<head>
	<title>Full Pie Chart</title>
	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
	<script type='text/javascript' src='/carsdisplay/include/jquery/jquery.min.js'></script>
	<script type="text/javascript">
	$(function() {
		google.charts.load( 'current', { 'packages':['corechart'] } );
		google.charts.setOnLoadCallback(drawChart);

		function drawChart() {

			var data = new google.visualization.DataTable();
			data.addColumn('string', 'Manufacturer');
			data.addColumn('number', 'Number in Database');
			data.addRows([ 
				{foreach $chartData as $k => $v}
					['{$k}', {$v}],
				{/foreach}
			]);

			var opts = {
				'title' : 'Breakdown of biggest car manufacturers (100+ cars)',
				'width' : 800,
				'height' : 600
			};

			var chart = new google.visualization.PieChart(document.getElementById('chartDiv'));
			chart.draw(data, opts);
		}
	

	});
	</script>
</head>
<body>
<div id="chartDiv"></div>
</body>
</html>











{/nocache}