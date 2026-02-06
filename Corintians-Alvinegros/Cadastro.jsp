<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Cadastro de Usuários</title>
</head>
<body>
    <h1>Gerenciamento de Usuários</h1>

    <!-- Formulário para adicionar novos registros -->
    <h2>Adicionar Novo Usuário</h2>
    <form method="post">
        Nome: <input type="text" name="nome" required><br>
        Email: <input type="email" name="email" required><br>
        CPF: <input type="text" name="cpf" maxlength="11" required><br>
        Data de Nascimento: <input type="date" name="dtnascimento" required><br>
        <button type="submit">Cadastrar</button>
    </form>

    <% 
        // Configurações do banco de dados
        String url = "jdbc:mysql://localhost:3306/cadastro_autialvi";
        String usuario = "seu_usuario";
        String senha = "sua_senha";

        // Conexão com o banco
        Connection conn = null;
        PreparedStatement stmt = null;

        // Captura dos dados do formulário
        String nome = request.getParameter("nome");
        String email = request.getParameter("email");
        String cpf = request.getParameter("cpf");
        String dtnascimento = request.getParameter("dtnascimento");

        try {
            // Carregar o driver JDBC
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, usuario, senha);

            if (nome != null && email != null && cpf != null && dtnascimento != null) {
                // Inserir os dados no banco
                String sql = "INSERT INTO cadastro (nome, email, cpf, dtnascimento) VALUES (?, ?, ?, ?)";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, nome);
                stmt.setString(2, email);
                stmt.setString(3, cpf);
                stmt.setDate(4, Date.valueOf(dtnascimento));
                int linhasAfetadas = stmt.executeUpdate();

                if (linhasAfetadas > 0) {
                    out.println("<p>Usuário cadastrado com sucesso!</p>");
                }
            }

            // Exibir os registros existentes
            out.println("<h2>Usuários Cadastrados</h2>");
            String sqlConsulta = "SELECT * FROM cadastro";
            stmt = conn.prepareStatement(sqlConsulta);
            ResultSet rs = stmt.executeQuery();

            out.println("<table border='1'><tr><th>ID</th><th>Nome</th><th>Email</th><th>CPF</th><th>Data de Nascimento</th></tr>");
            while (rs.next()) {
                out.println("<tr>");
                out.println("<td>" + rs.getInt("numregistro") + "</td>");
                out.println("<td>" + rs.getString("nome") + "</td>");
                out.println("<td>" + rs.getString("email") + "</td>");
                out.println("<td>" + rs.getString("cpf") + "</td>");
                out.println("<td>" + rs.getDate("dtnascimento") + "</td>");
                out.println("</tr>");
            }
            out.println("</table>");

        } catch (Exception e) {
            out.println("<p>Erro: " + e.getMessage() + "</p>");
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException ex) {
                out.println("<p>Erro ao fechar conexão: " + ex.getMessage() + "</p>");
            }
        }
    %>
</body>
</html>
