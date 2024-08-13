<?php
include 'config.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $nome = $_POST['nome'];
    $descricao = $_POST['descricao'];
    $precoVenda = $_POST['precoVenda'];
    $qtdeEstoque = $_POST['qtdeEstoque'];
    $marca = $_POST['marca'];
    $material = $_POST['material'];
    $cor = $_POST['cor'];

    $sql = "INSERT INTO Produto (nome, descricao, precoVenda, qtdeEstoque, marca, material, cor)
            VALUES ('$nome', '$descricao', $precoVenda, $qtdeEstoque, '$marca', '$material', '$cor')";

    if ($conn->query($sql) === TRUE) {
        header("Location: index.php");
    } else {
        echo "Erro: " . $sql . "<br>" . $conn->error;
    }
}
?>

<!DOCTYPE html>
<html>

<head>
    <title>Adicionar Produto</title>
</head>

<body>
    <h1>Adicionar Produto</h1>
    <form method="post">
        <label>Nome:</label><br>
        <input type="text" name="nome" required><br>
        <label>Descrição:</label><br>
        <input type="text" name="descricao"><br>
        <label>Preço:</label><br>
        <input type="number" step="0.01" name="precoVenda" required><br>
        <label>Quantidade em Estoque:</label><br>
        <input type="number" name="qtdeEstoque" required><br>
        <label>Marca:</label><br>
        <input type="text" name="marca"><br>
        <label>Material:</label><br>
        <input type="text" name="material"><br>
        <label>Cor:</label><br>
        <input type="text" name="cor"><br><br>
        <input type="submit" value="Salvar">
    </form>
    <a href="index.php">Voltar</a>
</body>

</html>

<?php
$conn->close();
?>