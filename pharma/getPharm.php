<?php

include 'conn.php';

$id = $_GET['id'];

$sql=$conn->query("SELECT * FROM pharmacies WHERE idVille = $id");

$res=array();

while ($row=$sql->fetch()) {
    $res[]=$row;
}

echo json_encode($res);

?>