<?php

include 'conn.php';


$userName = $_POST['userName'];
$repSecrete = $_POST['repScrete'];
$passWord = $_POST['passWord'];
$accountType = 'Premium';

$newUser =[
'userName' => $userName,
'repScrete' => $repSecrete,
'passWord' => $passWord,
'accountType' => $accountType

];


$stmt = $conn->prepare("INSERT INTO pharmUsers (userName, repScrete, passWord, accountType) VALUES (:userName, :repScrete, :passWord, :accountType)");

$stmt->execute($newUser);







?>