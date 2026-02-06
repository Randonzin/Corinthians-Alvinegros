require("conexao.php");

if (isset($_POST['nome'], $_POST['email'], $_POST['cpf'], $_POST['dtnascimento'])) {

    $nome = $_POST['nome'];
    $email = $_POST['email'];
    $cpf = $_POST['cpf'];
    $dtnascimento = $_POST['dtnascimento'];

    $query = "INSERT INTO tblcadastro (nome, email, cpf, dtnascimento, valor) 
              VALUES (:nome, :email, :cpf, :dtnascimento, :valor)";

    try {
        $stmt = $pdo->prepare($query);
        
        $stmt->bindParam(':nome', $nome);
        $stmt->bindParam(':email', $email);
        $stmt->bindParam(':cpf', $cpf);
        $stmt->bindParam(':dtnascimento', $dtnascimento);
        $stmt->bindParam(':valor', $valor);

        $stmt->execute();

        echo "Cadastro realizado com sucesso!";
    } catch (PDOException $e) {
        echo "Erro ao cadastrar: " . $e->getMessage();
    }

} else {
    echo "Por favor, preencha todos os campos.";
}
