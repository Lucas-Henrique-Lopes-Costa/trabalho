<?php
include 'config.php';

// Selecionar dados da tabela Produto
$sql = "SELECT * FROM Produto";
$result = $conn->query($sql);
?>

<!DOCTYPE html>
<html>

<head>
  <title>Gestão de Produtos</title>
</head>

<body>
  <h1>Lista de Produtos</h1>
  <a href="create.php">Adicionar Produto</a>
  <table border="1">
    <tr>
      <th>ID</th>
      <th>Nome</th>
      <th>Descrição</th>
      <th>Preço</th>
      <th>Quantidade</th>
      <th>Marca</th>
      <th>Material</th>
      <th>Cor</th>
      <th>Ações</th>
    </tr>
    <?php
    if ($result->num_rows > 0) {
      while ($row = $result->fetch_assoc()) {
        echo "<tr>
                    <td>" . $row["codProd"] . "</td>
                    <td>" . $row["nome"] . "</td>
                    <td>" . $row["descricao"] . "</td>
                    <td>" . $row["precoVenda"] . "</td>
                    <td>" . $row["qtdeEstoque"] . "</td>
                    <td>" . $row["marca"] . "</td>
                    <td>" . $row["material"] . "</td>
                    <td>" . $row["cor"] . "</td>
                    <td>
                        <a href='update.php?id=" . $row["codProd"] . "'>Editar</a>
                        <a href='delete.php?id=" . $row["codProd"] . "'>Excluir</a>
                    </td>
                </tr>";
      }
    } else {
      echo "<tr><td colspan='9'>Nenhum produto encontrado</td></tr>";
    }
    ?>
  </table>
</body>

</html>

<?php
$conn->close();
?>