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
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
    <title>Formulaire</title>
</head>

<body>

    <div class="container-fluid px-5">
        <div class="row justify-content-center mb-5">
            <div class="col-md">
                <nav class="navbar navbar-expand-lg navbar-light bg-light">
                    <a class="navbar-brand" href="#">HealthPoint</a>
                    <button class="navbar-toggler" type="button" data-toggle="collapse"
                        data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                        aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarSupportedContent">
                        <ul class="navbar-nav mr-auto">
                            <!-- <li class="nav-item active">
                                <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">Disabled</a>
                            </li> -->
                        </ul>
                        <button type="button" class="btn btn-sm btn-primary" data-toggle="modal"
                            data-target="#exampleModal">
                            Ajout ville <i class="fas fa-plus-square"></i>
                        </button>
                    </div>
                </nav>
            </div>
        </div>
        <div class="row justify-content-center">

            <!-- Button trigger modal -->

            <!-- Modal -->
            <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel"
                aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Ajouter une nouvelle ville</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <form action="" method="POST">
                                <div class="form-row">
                                    <div class="form-group col-md">
                                        <label for="inputEmail4">Nom de la ville</label>
                                        <input type="text" name="nom" id="" class="form-control">
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col-md-6">
                                        <label for="inputCity">Lattitude</label>
                                        <input type="text" name="lati" id="" class="form-control">
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label for="inputCity">Longitude</label>
                                        <input type="text" name="longi" id="" class="form-control">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <input type="submit" name="submitVille" id="" class="form-control btn btn-success"
                                        value="Enregistrer">
                                </div>

                        </div>
                        <!-- <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Annuler</button>

                        </div> -->
                        </form>
                    </div>
                </div>
                <?php
                if (isset($_POST['submitVille'])) {
                $nom = $_POST['nom'];
                $lati = $_POST['lati'];
                $longi = $_POST['longi'];

                $enwVille =[
                'nom' => $nom,
                'lati' => $lati,
                'longi' => $longi
                ];
                $db = new PDO("mysql:host=localhost;dbname=pharma",'root','');

                $stmt = $db->prepare("INSERT INTO villes (nom, lati, longi) VALUES (:nom, :lati, :longi)");

                $stmt->execute($enwVille);
                    if ($stmt) {
                            echo '
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                <strong>Réussite</strong> Informations enregistrées.
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            ';
                    }
                }
                ?>
            </div>
            
            <div class="col-md-4">
                <!-- <div class="row justify-content-center">
                    <div class="col-md-6">
                        <img class="text-center" src="images/logoApp.png" width="200" height="200">
                    </div>
                </div> -->
                <p class="text-center">Ajouter une pharmacie</p>
                <form action="" method="POST">
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label for="inputEmail4">Nom Pharmacie</label>
                            <input type="text" name="nom" id="" class="form-control">
                        </div>
                        <div class="form-group col-md-6">
                            <label for="">Pharmacien</label>
                            <input type="text" name="responsable" id="" class="form-control">
                        </div>
                    </div>
                    <div class="form-group ">
                        <label for="inputState">Ville</label>
                        <select id="inputState" class="form-control"
                            class="form-control custom-select bg-light rounded-0" name="idVille" required>
                            <?php
                            include 'conn.php';
                            $stmt = $conn->query("SELECT * FROM villes");
                            $stmt->execute();
                            foreach($stmt as $row)
                            {
                            /*** create the options ***/
                            echo '<option value="'.$row['id'].'" '; 
                            echo '>'. ucwords($row['nom']) . '</option>'."\n";
                            }
                            ?>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="">Contacts</label>
                        <input type="text" name="tel" id="" class="form-control">
                    </div>
                    <p>Informations géographiques de la pharmacie <i class="fas fa-info-circle"></i></p>
                    <hr>
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label for="inputCity">Lattitude</label>
                            <input type="text" name="lati" id="" class="form-control">
                        </div>
                        <div class="form-group col-md-6">
                            <label for="inputCity">Longitude</label>
                            <input type="text" name="longi" id="" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <input type="submit" name="submit" id="" class="form-control btn btn-success">
                    </div>
                </form>
                <?php

        if (isset($_POST['submit'])) {

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
        'longi' => $longi
        ];
		$db = new PDO("mysql:host=localhost;dbname=pharma",'root','');

		$stmt = $db->prepare("INSERT INTO pharmacies (nom, responsable, tel, idville, lati, longi) VALUES (:nom, :responsable, :tel, :idville, :lati, :longi)");

        $stmt->execute($newlivre);
            if ($stmt) {
                    echo '
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <strong>Réussite</strong> Informations enregistrées.
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    ';
            }
        }
 ?>
            </div>
            <div class="col-md-8 mt-5">
                <table class="table table-striped table-responsive col-md-12">
                    <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col">Nom Pharmacie</th>
                            <th scope="col">Nom Pharmacien</th>
                            <th scope="col">Contact</th>
                            <th scope="col">Ville</th>
                        </tr>
                    </thead>
                    <tbody>
                    <?php
                            include 'conn.php';
                            $stmt = $conn->query("SELECT * FROM pharmacies");
                            $stmt->execute();
                            foreach($stmt as $row)
                            { ?>
                            <tr>
                                <th> <? echo $row['id'] ?> </th>
                                <th> <? echo $row['nom'] ?> </th>
                                <th> <? echo $row['responsable'] ?> </th>
                                <th> <? echo $row['tel'] ?> </th>
                                <th> <? echo $row['idVille'] ?> </th>
                            </tr>
                            <?php }
                            ?>
                        

                    </tbody>
                </table>
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