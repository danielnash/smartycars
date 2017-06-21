<?php
require 'include/Core.class.php';

class homePage extends Core {

	public function __construct() {
		
		parent::__construct();
		
		if (!isset($_GET['manu'])) {
			$this -> fullQuery();
		}
		else if ($_GET['manu'] == '') {
			$this -> fullQuery();
		}
		else {
			$this -> manu = $_GET['manu'];
			$tableData = array();
			$tableQuery = mysqli_query($this -> database, "SELECT * FROM `vehiclemodelyear` WHERE make = '" . $this -> manu . "' ORDER BY id asc;");

			while ($row = mysqli_fetch_assoc($tableQuery)) {
				$tableData[$row['id']] = array($row['year'] => $row['model']);
			}
			$this -> template -> assign('tableData', $tableData);
			$tableQuery -> close();
		}

		$manufacts = array();
		$manQuery = mysqli_query($this -> database, 'SELECT DISTINCT make FROM `vehiclemodelyear`;');
		while ($row = mysqli_fetch_assoc($manQuery)) {
			$manufacts[] = $row['make'];
		}
		
		$this -> template -> assign('dropOpts', $manufacts);
		$this -> template -> assign('selopt', $this -> manu);
		$manQuery -> close();
	}

	function fullQuery() {
		$this -> manu = '';
		$tableData = array();
		$tableQuery = mysqli_query($this -> database, "SELECT * FROM `vehiclemodelyear`;");
		while ($row = mysqli_fetch_assoc($tableQuery)) {
			$tableData[$row['id']] = array($row['year'] => $row['model']);
		}
		$this -> template -> assign('tableData', $tableData);
		$tableQuery -> close();
	}

	public function render() {
		$this -> template -> display('homepage.tpl');
		$this -> clean();
	}

}


$hp = new homePage();
$hp -> render();

?>
