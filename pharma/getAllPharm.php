<?php

include 'conn.php';



$sql=$conn->query("SELECT * FROM pharmacies ");

$res=array();

while ($row=$sql->fetch()) {
    $res[]=$row;
}

echo json_encode($res);

?>