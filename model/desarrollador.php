<?php
$rutaBase = 'c:/webapp/Portafolio/apiVanilla/';
class Desarrollador
{
    public function __construct()
    {
        require_once($GLOBALS['rutaBase'].'modelo/connect.php');
        $conn = new Connect();
    }   
}
?>