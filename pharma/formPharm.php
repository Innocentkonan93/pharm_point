<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
        integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <title>Formulaire</title>
</head>
<body>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <ul>
            <li>id ville Abidjan : 1</li>
            <li>id ville abengourou : 2</li>
            <li>id ville aboisso : 3</li>
            <li>id ville agnibilekro : 4</li>
            <li>id ville anyama : 5</li>
            <li>id ville agboville : 6</li>
           </ul>
        </div>
        <div class="col-md-6 p-5">
            
<?php

if (isset($_POST['submit'])) {

include 'conn.php';

$nom = $_POST['nom'];

$responsable = $_POST['responsable'];

$tel = $_POST['tel'];

$idville = $_POST['idVille'];

$lati = $_POST['lati'];

$longi = $_POST['longi'];




$newlivre =[
'nom' => $nom,
'responsable' => $responsable,
'tel' => $tel,
'idville' => $idville,
'lati' => $lati,
'longi' => $longi,


];

	$stmt = $conn->prepare("INSERT INTO pharmacies (nom, responsable, tel, idville, lati, longi) VALUES (:nom, :responsable, :tel, :idville, :lati, :longi)");
    $stmt->execute($newlivre);

      if ($stmt) {
        echo '<div class="alert alert-success alert-dismissible fade show" role="alert">
                  <strong>Réussité!</strong> Officine ajoutée avec succès.
                  <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                  </button>
                </div>
            ';
      }
}


 ?>
            <form action="" method="POST">
                
                <div class="form-group">
                    <label for="">Nom Pharmacie</label>
                    <input type="text" name="nom" id="" class="form-control">
                </div>
                <div class="form-group">
                    <label for="">Responsbale</label>
                    <input type="text" name="responsable" id="" class="form-control">
                </div>
                <div class="form-group">
                    <label for="">tel</label>
                    <input type="text" name="tel" id="" class="form-control">
                </div>
                <div class="form-group">
                    <label for="">idVille</label>
                    <input type="number" name="idVille" id="" class="form-control">
                </div>
                <div class="form-group">
                    <label for="">lati</label>
                    <input type="text" name="lati" id="" class="form-control">
                </div>
                <div class="form-group">
                    <label for="">longi</label>
                    <input type="text" name="longi" id="" class="form-control">
                </div>
                <div class="form-group">
                    <input type="submit" name="submit" id="" class="form-control btn btn-success">
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
        integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous">
    </script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"
        integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous">
    </script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"
        integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous">
    </script>
</body>
</html>
