{nocache}
<!DOCTYPE html>
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel='stylesheet' type='text/css' href='/carsdisplay/include/bootstrap/bootstrap.min.css'>
	<link rel='stylesheet' type='text/css' href='/carsdisplay/include/jquery/jquery-ui.min.css'>
	<link rel='stylesheet' type='text/css' href='/carsdisplay/include/select2/select2.min.css'>
	<link rel="stylesheet" type="text/css" href="/carsdisplay/include/datatables/datatables.min.css">
	<style type='text/css'>

		#mainSelect {
			width: 20%;
		}

		#pieChartLink {
			background: #f9f9f9; 
			color: grey;
			border: 1px solid grey;
			padding: 8px 7px;
			margin: 20px 5px;
		}

	</style>
	<script type='text/javascript' src='/carsdisplay/include/jquery/jquery.min.js'></script>
	<script type='text/javascript' src='/carsdisplay/include/jquery/jquery-ui.min.js'></script>
	<script type='text/javascript' src='/carsdisplay/include/datatables/datatables.min.js'></script>
	<script type='text/javascript' src='/carsdisplay/include/select2/select2.full.min.js'></script>
	<script type='text/javascript' src='/carsdisplay/include/bootstrap/bootstrap.min.js'></script>
	<script type='text/javascript'>

		$(function() {
			$('#mainSelect').select2();
			$('#resultsTable').DataTable({
				'ordering' : false
			});

			$('#mainSelect').change(function() {
				window.location.href = '/carsdisplay/homepage.php?manu=' + $(this).val();
			});	

			$('#seeAll').click(function() {
				window.location.href = '/carsdisplay/homepage.php?manu=';
			});	

			$('#pieChartLink').click(function() {
				window.location.href = '/carsdisplay/piechart.php';
			});
		});

	</script>
	<title>Home Page</title>
</head>
<body>
<div class="container" style="padding-top: 10px;">
<select class='js-example-basic-single' id='mainSelect'>
	{foreach $dropOpts as $opt}
		<option {if $opt eq $selopt} selected {/if} value='{$opt}'>{$opt}</option>
	{/foreach}
</select>
<button id='seeAll'>All manufacturers</button>
<div id='titleArea'>
	{if $selopt neq ''}<h2>Currenly Selected: {$selopt}</h2>{/if}
<div style="width: 25%;"><button id="pieChartLink">Data pie chart</button></div>
</div>
<br>
<br>
<div class='table-responsive'>
<table id='resultsTable' class="table table-striped">
	<thead>
      <tr>
        <th>ID</th>
        <th>Year of Release</th>
        <th>Model Name</th>
      </tr>
    </thead>
    <tbody>
     	{foreach $tableData as $k => $v}
     		<tr>
     			<td>{$k}</td>
     			{foreach $v as $ki => $vi}
     				<td>{$ki}</td>
     				<td>{$vi}</td>
     			{/foreach}
     		</tr>
     	{/foreach}
    </tbody>
</table>
</div>
</div>
</body>
</html>
{/nocache}