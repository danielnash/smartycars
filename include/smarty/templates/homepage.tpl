{nocache}
<!DOCTYPE html>
<html>
<head>
{literal}
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel='stylesheet' type='text/css' href='/carsdisplay/include/bootstrap/bootstrap.min.css'>
	<link rel='stylesheet' type='text/css' href='/carsdisplay/include/jquery/jquery-ui.min.css'>
	<link rel='stylesheet' type='text/css' href='/carsdisplay/include/jquery/jquery-ui.theme.css'>
	<link rel='stylesheet' type='text/css' href='/carsdisplay/include/select2/select2.min.css'>
	<link rel="stylesheet" type="text/css" href="/carsdisplay/include/datatables/datatables.min.css">
	<style type='text/css'>

		#mainSelect {
			width: 20%;
		}

		#pieChartLink {
			padding: 8px 7px;
			margin: 20px 5px;
		}

		.dialogdiv {
   			display: none;
			font-size: 12pt;
		}

		.ui-dialog-titlebar-close {
   			visibility: hidden;
		}

	</style>
	<script type='text/javascript' src='/carsdisplay/include/jquery/jquery.min.js'></script>
	<script type='text/javascript' src='/carsdisplay/include/jquery/jquery-ui.min.js'></script>
	<script type='text/javascript' src='/carsdisplay/include/datatables/datatables.min.js'></script>
	<script type='text/javascript' src='/carsdisplay/include/select2/select2.full.min.js'></script>
	<script type='text/javascript' src='/carsdisplay/include/bootstrap/bootstrap.min.js'></script>
	<script type='text/javascript'>
		
		$(function() {
			$('button').addClass('ui-button ui-widget ui-state-default ui-corner-all');
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

			$.fn.extend({
				multipagemodal: function() {
					$(this).fadeOut(function() {
						var incPageNum = parseInt($(this).attr("data-pageNum")) + 1;
						$(this).text($('[data-pageNum = "' + incPageNum + '"]').html()).fadeIn();
						$(this).attr('data-pageNum', incPageNum);
						if (!($('[data-pageNum="' + (parseInt($(this).attr("data-pageNum")) + 1) + '"]').length)) {
							$('#nextButton').attr('disabled', true).addClass('ui-state-disabled');
						};
					});
				}
			});

			$('#infoButton').click(function() {
				$('.dialogdiv').css('visibility', 'visible');
				$('#dialogmsg').dialog({
 					modal: true,
					resizable: false,
					minWidth: 400,
					show: { effect: 'fade', duration: '800' },
					buttons: [
						{ 
							text: 'Next page',
							id: 'nextButton',
							'class': "ui-button ui-widget ui-state-default ui-corner-all",
							icons: { 
								primary: 'ui-icon-key'
							},
							click: function() { 
								$(this).multipagemodal();
							} 
						},
						{
							text: 'Got it!',
							'class': "ui-button ui-widget ui-state-default ui-corner-all",
							icons: {
								primary: 'ui-icon-check' 
							},
							click: function() { 
								$(this).dialog('close'); 
							}
						} 
					] 
				});
			});
		});

	</script>
	<title>Home Page</title>
</head>
{/literal}
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
<div style="width: 40%; float: right;"><button id='infoButton'>Extra Information</button></div>
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
<div class="dialogdiv" id="dialogmsg" data-pageNum='1' title="Information">This is a table of all the cars / manufacturers in the database</div>
<div class="dialogdiv" data-pageNum='2'>You can use the 'search' feature to find specific models, dates or manufacturers</div>
<div class="dialogdiv" data-pageNum='3'>The ID is unique in the database and can be used to reference specific models</div>
</body>
</html>
{/nocache}