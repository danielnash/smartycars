<?php
require 'include/Core.class.php';

class pieChart extends Core {

	function render() {
		global $queryResult;
		$queryResult = mysqli_query($this -> database, 'SELECT make FROM `vehiclemodelyear`;');
		$formattedRes = array();
		$totalCount = 0;
		while ($row = mysqli_fetch_assoc($queryResult)) {
			if (!(array_key_exists($row['make'], $formattedRes))) {
				$formattedRes[$row['make']] = 1;
			}
			else {
				$formattedRes[$row['make']]++;
			}
			$totalCount++;
		}

		$this -> cData = $formattedRes;
		$otherData = $this -> filterOther(100);
		$this -> template -> assign('otherTable', $otherData);
		$this -> template -> assign('chartData', $this -> cData);
		$this -> template -> display('pie.tpl');
	}

	function filterOther($minForOther) {
		$otherCount = 0;
		$otherTable = array();
		foreach ($this -> cData as $k => $v) {
			if (intval($v) < $minForOther) {
				$otherTable[$k] = $v; 
				unset($this -> cData[$k]);
				$otherCount += intval($v);
			}
		}
		$this -> cData = $this -> cData + array('Other' => $otherCount);
		return $otherTable;
	}

}

$pie = new pieChart();
$pie -> render();
$pie -> clean();

?>