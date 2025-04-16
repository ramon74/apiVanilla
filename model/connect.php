<?php
$rutaBase = 'c:/webapp/Portafolio/apiVanilla/';
class Connect
{
    private $connection;
    public function __construct()
    {
        try
        {
            require_once($GLOBALS['rutaBase'].'parameter.php');
            $dc = $param['dc'];
            $conn = mysqli_connect($dc['server'],$dc['usuario'],$dc['password'],$dc['db'],$dc['port']);
            $code = 1;
        }
        catch(Exception $e)
        {
            $conn = $e->getMessage();
            $code = -1;
        }
        finally
        {
            $this->connection = array('code'=>$code,'output'=>$conn);
        }
    }
    
    public function getConnection()
    {
        return $this->connection;
    }
    
}
$x = new connect();
print_r($x->getConnection());
?>