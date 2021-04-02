<?php
    
    $db_host="ftp.bad-event.com"; // localhost server
    $db_user="badevent_admin"; //nom de l'utilisateur de la base de donnée
    $db_password="admin@2020"; //mot de passe utilisateur
    $db_name="badevent_data"; //nom de la base de donnée

    try
    {
        $conn = new PDO("mysql:host={$db_host};dbname={$db_name}",$db_user,$db_password);
        $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        //retourner les resultats en objet
        // $db->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_OBJ);

    }
    catch (PDOEXCEPTION $e)
    {
        $e->getMessage();
    }
   
?>