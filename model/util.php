<?php
$rutaBase = 'c:/webapp/Portafolio/apiVanilla/';
class Util
{
    public function __construct()
    {
        require_once($GLOBALS['rutaBase'].'modelo/connect.php');
        $conn = new Connect();
    }   
}
?>