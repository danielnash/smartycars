<?php
require 'smarty/Smarty.class.php';

class Core {

	public function __construct($dbName = 'cars') {
		$this -> template = new Smarty();
		$this -> template -> setTemplateDir(($_SERVER['DOCUMENT_ROOT']) . '/carsdisplay/include/smarty/templates/');
		$this -> template -> setCompileDir($_SERVER['DOCUMENT_ROOT'] . '/carsdisplay/include/smarty/template_c/');

		$this -> database = mysqli_connect('localhost', 'root', '', $dbName);
		if (!$this -> database) {
			echo '<h2>Error with DB Connection</h2>';
			die();
		}
	}

	public function clean() {
		mysqli_close($this -> database);
	}


}

?>
