<?php
require 'include/Core.class.php';

class pieChart extends Core {

	function render() {
		$queryResult = mysqli_query($this -> database, 'SELECT * FROM `vehiclemodelyear`;');
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
		$this -> filterOther();

		$this -> template -> assign('chartData', $this -> cData);
		$this -> template -> display('pie.tpl');
	}

	function filterOther() {
		$otherCount = 0;
		foreach ($this -> cData as $k => $v) {
			if (intval($v) < 100) {
				unset($this -> cData[$k]);
				$otherCount += intval($v);
			}
		}
		$this -> cData = $this -> cData + array('Other' => $otherCount);
	}

	public function reload() {

	}

}

$pie = new pieChart();
$pie -> render();

?>