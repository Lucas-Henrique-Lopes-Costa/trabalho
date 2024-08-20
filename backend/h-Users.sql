/*
  Exemplos de utilização:
    - Logue com o usuário criado no Banco de dados após serem dados os seus privilégios.
    - A partir dos privilégios dados, teste com queries para ver se os privilégios estão condizentes:
        Exemplo:
          O usuário denilson terá permissões para executar qualquer query e operações de CRUD no banco de dados
          já que foram dadas todas as permissões para ele no GRAND PRIVILEGES

          Já o usuário Joao só poderá utilizar, exclusivamente, queries com SELECT e INSERT na tabela de Produto.

          Após o REVOKE do usuário denilson, foi retirado a possibilidade de executar queries com DELETE em todas as tabelas do banco.
          Já o REVOKE do usuário Joao, foi revogado o direito de executar queries com INSERT na tabela Produto, além das outras restrições.

*/

-- Criação dos usuários 
CREATE USER 'denilson'@'localhost' IDENTIFIED BY 'BDTrabalho';
CREATE USER 'Joao'@'localhost' IDENTIFIED BY 'mudar123';

-- Da todas as permissões de CRUD ao usuário Denilson
GRANT ALL PRIVILEGES ON BD_Trabalho.* TO 'denilson'@'localhost';

-- Da somente as permissões de Selecionar e Inserir dados na tabela produto ao usuário Joao
GRANT SELECT, INSERT ON BD_Trabalho.Produto TO 'Joao'@'localhost';

-- Retira a opção de deletar dados do usuário Denilson
REVOKE DELETE ON BD_Trabalho.* FROM 'denilson'@'localhost';

-- Retira a opção de Inserir dados na tabela produto do usuário Joao
REVOKE INSERT ON BD_Trabalho.Produto FROM 'Joao'@'localhost';

