<?php

include 'conn.php';



$userName = $_POST['userName'];
$passWord = $_POST['passWord'];



$sql=$conn->query("SELECT * FROM pharmUsers WHERE userName = '$userName' AND passWord = '$passWord'");

$res=array();

while ($row=$sql->fetch()) {
    $res[]=$row;
}

echo json_encode($res);


?>