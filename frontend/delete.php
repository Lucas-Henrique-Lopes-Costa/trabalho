<?php
include 'config.php';

$id = $_GET['id'];

$sql = "DELETE FROM Produto WHERE codProd = $id";

if ($conn->query($sql) === TRUE) {
    header("Location: index.php");
} else {
    echo "Erro: " . $sql . "<br>" . $conn->error;
}

$conn->close();