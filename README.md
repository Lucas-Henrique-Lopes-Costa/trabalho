UFLA - Universidade Federal de Lavras
DCC - Departamento de Ciência da Computação
GCC214 - Introdução a Sistemas de Banco de Dados
Prof. Denilson Alves Pereira

# Trabalho Prático – Etapa 3

Implementação em SQL
Deve ser entregue em um único arquivo PDF por meio do Campus Virtual
Valor: 10 pontos (aproveitamento inferior a 50% dos pontos nesta etapa recebe nota zero em todo o trabalho)
Data limite de entrega: 20/08/2024
O objetivo deste trabalho é implementar o banco de dados definido nas Etapas 1 e 2 em um SGBD relacional e criar um exemplo de interface Web com o usuário.
Crie as tabelas, restrições de integridade, procedimentos, triggers e faça consultas, inserções, modificações e exclusões de dados conforme descrito abaixo. Apresente os comandos SQL (scripts), bem como uma descrição detalhada explicando o que cada comando faz em cada item abaixo.

(f) Exemplos de, pelo menos, 12 consultas. Inclua consultas simples e complexas, envolvendo todas as cláusulas do comando de consulta (SELECT, FROM, WHERE, ORDER BY, GROUP BY, HAVING), os operadores (JOIN, OUTER JOIN, UNION, AND, OR, NOT, BETWEEN, IN, LIKE, IS NULL, ANY/SOME, ALL, EXISTS), além de funções agregadas e consultas aninhadas (subconsultas). Não faça aninhamentos "forçados", somente os use em situações onde é difícil escrever uma consulta sem aninhamento. Será avaliado o nível de complexidade das consultas apresentadas. Não se esqueça de descrever em detalhes o que cada consulta recupera (ex: recupera o nome e o endereço dos gerentes dos departamentos que controlam os projetos localizados em Lavras) (valor: 50%);

Definição: 3 Consultas para cada:

LUCAS HENRIQUE LOPES COSTA
PEDRO GONÇALVES COSTA MELO
GUSTAVO DE JESUS TEODORO
THIAGO LIMA PEREIRA
LUCAS SCOMMEGNA

Extra: Corrigir as outras etapas 1 e 2
diagrama ER,
o dicionário de dados do ER,
o diagrama relacional
e o dicionário de dados do relacional
Responsável: THIAGO LIMA PEREIRA

Sobre a interface com o usuário:
Crie uma interface Web em PHP para cadastrar, consultar, alterar e excluir dados de, pelo menos, uma das tabelas do banco de dados (valor: 10%);
É de responsabilidade do grupo efetuar todas as configurações necessárias para apresentar o programa funcionando (servidor e outras);
Responsável: LUCAS HENRIQUE LOPES COSTA

(i) Exemplos de 3 procedimentos/funções, com e sem parâmetros, de entrada e de saída, contendo alguns comandos tais como IF, CASE WHEN, WHILE, declaração de variáveis e funções prontas. Os procedimentos devem ter aplicação no seu projeto. Inclua exemplos de como executar esses procedimentos/funções (valor: 10%);
Responsável: PEDRO GONÇALVES COSTA MELO

(j) Exemplos de 3 triggers, um para cada evento (inserção, alteração e exclusão). Os triggers devem ter aplicação no seu projeto. Inclua exemplos de como disparar os triggers (valor: 10%).
Responsável: Gustavo Teodoro

(g) Exemplos de criação de de 3 visões (Views). Inclua também exemplos de como usar cada uma das visões (valor: 5%);
(h) Exemplos de criação de usuários (pelo menos 2), concessão (GRANT) e revocação (REVOKE) de permissão de acesso (valor: 5%);
Responsável: LUCAS SCOMMEGNA


(a) Criação de todas as tabelas e de todas as restrições de integridade. Todas as restrições de chave (PRIMARY KEY) e de integridade referencial (FOREIGN KEY) devem ser criadas. Além disso, crie pelo menos um exemplo com cada uma das restrições UNIQUE e DEFAULT (valor: 2,5%);
(b) Exemplos de ALTER TABLE (pelo menos 3 exemplos, envolvendo alterações diversas) e DROP TABLE. Crie uma tabela extra que não existe no seu trabalho, somente para exemplificar, e a apague no final com o DROP TABLE (valor: 2,5%);
Responsável: LUCAS SCOMMEGNA


(c) Exemplo de uma inserção de dados em cada uma das tabelas. Para testar o trabalho, recomenda-se inserir dezenas de registros em cada tabela. Mostre esses dados na apresentação do trabalho (valor: 1,7%);
(d) Exemplos de modificação de dados em 5 tabelas. Mostre pelo menos um exemplo com UPDATE aninhado, envolvendo mais de uma tabela (valor: 1,7%);
(e) Exemplos de exclusão de dados em 5 tabelas. Mostre pelo menos um exemplo com DELETE aninhado, envolvendo mais de uma tabela (valor: 1,7%);
Responsável: THIAGO LIMA PEREIRA

O que deve ser entregue:
Um único documento no formato PDF contendo o diagrama ER, o dicionário de dados do ER, o diagrama relacional e o dicionário de dados do relacional corrigidos, e as solicitações da Etapa 3.
O código fonte da interface Web não precisa ser adicionado ao documento de entrega, apenas mostrado e explicado ao professor no dia da apresentação.

O trabalho deve ser apresentado ao professor em data/horário agendado no final do semestre. Deixe o banco de dados criado e os dados de teste inseridos. Todos os códigos a partir do item (f) deverão ser executados na presença do professor. Leve um script de todos os códigos e mostre que eles estão funcionando. Nessa apresentação, será feita uma avaliação da participação de cada membro do grupo.
