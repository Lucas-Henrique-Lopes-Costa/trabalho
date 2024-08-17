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

