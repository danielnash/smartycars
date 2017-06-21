{nocache}
<!DOCTYPE html>
<html>
<head>
    <title>Full Pie Chart</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel='stylesheet' type='text/css' href='/carsdisplay/include/bootstrap/bootstrap.min.css'>
    <link rel='stylesheet' type='text/css' href='/carsdisplay/include/jquery/jquery-ui.min.css'>
    <link rel='stylesheet' type='text/css' href='/carsdisplay/include/select2/select2.min.css'>
    <link rel="stylesheet" type="text/css" href="/carsdisplay/include/datatables/datatables.min.css">
    <style type="text/css">
        
    </style>
    <script type="text/javascript" src='/carsdisplay/include/chartloader.js'></script>
    <script type='text/javascript' src='/carsdisplay/include/jquery/jquery.min.js'></script>
    <script type='text/javascript' src='/carsdisplay/include/jquery/jquery-ui.min.js'></script>
    <script type='text/javascript' src='/carsdisplay/include/datatables/datatables.min.js'></script>
    <script type='text/javascript' src='/carsdisplay/include/select2/select2.full.min.js'></script>
    <script type='text/javascript' src='/carsdisplay/include/bootstrap/bootstrap.min.js'></script>
    <script type="text/javascript">
    $(function() {
        $('button').addClass('ui-button ui-widget ui-state-default ui-corner-all');
        $('#bHome').click(function() {
            window.location.href = '/carsdisplay/homepage.php?manu=';
        }); 
        google.charts.load( 'current', { 'packages' : ['corechart'] } );
        google.charts.setOnLoadCallback(drawChart);
        
        $('#otherTable').DataTable({
            'order' : [[1, 'desc']]
        });

        $('#otherTableDiv').hide();

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

            $(document).click(function(e) {
                if (e.clientY < 600) {
                    $('#otherTableDiv').hide();
                }
            });

            var chart = new google.visualization.PieChart(document.getElementById('chartDiv'));
            chart.draw(data, opts);

            google.visualization.events.addListener(chart, 'select', function(event) {
                var sel = chart.getSelection()[0];
                if (sel) {
                    if (data.getValue(sel.row, 0) == 'Other') {
                        $('#otherTableDiv').show();
                    }
                    else {
                        $('#otherTableDiv').hide();
                    }
                }
            });
        }
    

    });
    </script>
</head>
<body>
<button id="bHome">Home</button>
<div id="chartDiv"></div>
<div id="otherTableDiv" class='table-responsive'>
    <h4>This is a breakdown of the "Other" category</h4>
    <table id='otherTable' class="table table-striped">
        <thead>
            <tr>
                <td>Manufacturer</td>
                <td>Number of Cars</td>
            </tr>
        </thead>
        <tbody>
        {foreach $otherTable as $k => $v}
            <tr>
                <td>{$k}</td>
                <td>{$v}</td>
            </tr>
        {/foreach}
        </tbody>
    </table>
</div>
</body>
</html>











{/nocache}