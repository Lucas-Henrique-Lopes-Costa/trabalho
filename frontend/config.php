<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

$servername = "localhost"; // Alterar se necessário
$username = "estudante"; // Alterar se necessário
$password = "2022#estudante"; // Alterar se necessário
$dbname = "BD_Trabalho"; // Alterar se necessário

// Criando a conexão
$conn = new mysqli($servername, $username, $password, $dbname);

// Verificando a conexão
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
