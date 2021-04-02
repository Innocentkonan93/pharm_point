<?php

include 'conn.php';



$sql=$conn->query("SELECT * FROM villes");

$res=array();

while ($row=$sql->fetch()) {
    $res[]=$row;
}

echo json_encode($res);

?>