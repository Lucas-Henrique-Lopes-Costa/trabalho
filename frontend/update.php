<?php
include 'config.php';

$id = $_GET['id'];

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $nome = $_POST['nome'];
    $descricao = $_POST['descricao'];
    $precoVenda = $_POST['precoVenda'];
    $qtdeEstoque = $_POST['qtdeEstoque'];
    $marca = $_POST['marca'];
    $material = $_POST['material'];
    $cor = $_POST['cor'];

    $sql = "UPDATE Produto SET 
            nome = '$nome', 
            descricao = '$descricao', 
            precoVenda = $precoVenda, 
            qtdeEstoque = $qtdeEstoque, 
            marca = '$marca', 
            material = '$material', 
            cor = '$cor'
            WHERE codProd = $id";

    if ($conn->query($sql) === TRUE) {
        header("Location: index.php");
    } else {
        echo "Erro: " . $sql . "<br>" . $conn->error;
    }
} else {
    $sql = "SELECT * FROM Produto WHERE codProd = $id";
    $result = $conn->query($sql);
    $row = $result->fetch_assoc();
}
?>

<!DOCTYPE html>
<html>

<head>
    <title>Editar Produto</title>
</head>

<body>
    <h1>Editar Produto</h1>
    <form method="post">
        <label>Nome:</label><br>
        <input type="text" name="nome" value="<?php echo $row['nome']; ?>" required><br>
        <label>Descrição:</label><br>
        <input type="text" name="descricao" value="<?php echo $row['descricao']; ?>"><br>
        <label>Preço:</label><br>
        <input type="number" step="0.01" name="precoVenda" value="<?php echo $row['precoVenda']; ?>" required><br>
        <label>Quantidade em Estoque:</label><br>
        <input type="number" name="qtdeEstoque" value="<?php echo $row['qtdeEstoque']; ?>" required><br>
        <label>Marca:</label><br>
        <input type="text" name="marca" value="<?php echo $row['marca']; ?>"><br>
        <label>Material:</label><br>
        <input type="text" name="material" value="<?php echo $row['material']; ?>"><br>
        <label>Cor:</label><br>
        <input type="text" name="cor" value="<?php echo $row['cor']; ?>"><br><br>
        <input type="submit" value="Salvar">
    </form>
    <a href="index.php">Voltar</a>
</body>

</html>

<?php
$conn->close();
?>