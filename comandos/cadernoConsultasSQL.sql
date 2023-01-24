DOCUMENTAÇÃO DO MYSQL:  https://dev.mysql.com/doc/
						https://w3schools.com


Busca todos com sabor Laranja:
>	SELECT * FROM tabela_de_produtos WHERE SABOR = 'Laranja'; 


Busca todos com campo da coluna PRCO_DE_LISTA > 19.50:
>	SELECT * FROM tabela_de_produtos WHERE PRECO_DE_LISTA > 19.50;


Busca entre 19.50 e 19.52 (é necessário uso do BETWEEN pq se colocarmos apenas 19.50 dificilmente ira ser encontrado no banco pq é tipo float):
>	SELECT * FROM tabela_de_produtos WHERE PRECO_DE_LISTA BETWEEN 19.50 AND 19.52; 


Busca sabor manga OU(OR) tamanho = 470ml:
>	SELECT * FROM tabela_de_produtos WHERE SABOR = 'Manga' OR TAMANHO = '470 ml';


Busca sabor manga E(AND) tamanho = 470ml:
>	SELECT * FROM tabela_de_produtos WHERE SABOR = 'Manga' AND TAMANHO = '470 ml';


Busca onde sabor contém Maça no meio da descrição % --- % :
>	SELECT * FROM tabela_de_produtos WHERE SABOR LIKE '%Maça%';


Busca onde sabor contém Maça no inicio da descrição --- % :
>	SELECT * FROM tabela_de_produtos WHERE SABOR LIKE 'Maça%';


Busca onde sabor contém Maça no final da descrição % --- :
>	SELECT * FROM tabela_de_produtos WHERE SABOR LIKE '%Maça';


Busca somente os bairros diferentes da cidade Rio de janeiro (DISTINCT não busca dois bairros com o mesmo nome na tab de clientes):
>	SELECT DISTINCT BAIRRO FROM tabela_de_clientes WHERE CIDADE = 'Rio de Janeiro' 


Busca valores de embalagem diferente, tamanho e sabor na tabela_de_produtos:
>	SELECT DISTINCT EMBALAGEM, TAMANHO, SABOR FROM tabela_de_produtos;


Busca na tabela notas_fiscais todos com DATA_VENDA'2017-01-01' somente os 10 primeiros registros (limit 10):
>	SELECT * FROM notas_fiscais  WHERE DATA_VENDA = '2017-01-01' limit 10


Busca a partir do segundo registro(inclusive ele) os próximos 3 registros (limit 2,3):
>	SELECT * FROM tabela_de_produtos LIMIT 2,3;


Busca todos registros da tebela ordenados por PRECO_DE_LISTA:
>	SELECT * FROM tabela_de_produtos ORDER BY PRECO_DE_LISTA;


Busca e ordena por EMBALAGEM em ordem decrescente e por NOME_DO_PRODUTO em ordem crescente:
>	SELECT * FROM tabela_de_produtos ORDER BY EMBALAGEM DESC, NOME_DO_PRODUTO ASC;


Busca qual (ou quais) foi (foram) a(s) maior(es) venda(s) do produto “Linha Refrescante - 1 Litro - Morango/Limão”, em quantidade:

1) buscar o código desse produto:
>	SELECT * FROM tabela_de_produtos WHERE nome_do_produto = 'Linha Refrescante - 1 Litro - Morango/Limão'

2) buscar na tabela de itens da nota fiscal todas as vendas que aparecem esse produto(ordenado ema ordem decrescente: ORDER BY DESC):
>	SELECT * FROM itens_notas_fiscais WHERE codigo_do_produto = '1101035' ORDER BY QUANTIDADE DESC


Busca qual a maior qtdade de venda para um determinado produto :
>	SELECT MAX(`QUANTIDADE`) as 'MAIOR QUANTIDADE' FROM itens_notas_fiscais WHERE `CODIGO_DO_PRODUTO` = '1101035' ;


Busca a qtdade de itens de nota para o produto determinado com qtde = 99 (99 é o resultado da busca anterior):
>	SELECT COUNT(*) FROM itens_notas_fiscais WHERE codigo_do_produto = '1101035' AND QUANTIDADE = 99;


Busca quais foram os clientes que fizeram mais de 2000 compras em 2016:

>	  SELECT CPF, COUNT(*) FROM notas_fiscais
  	  WHERE YEAR(DATA_VENDA) = 2016
      GROUP BY CPF
      HAVING COUNT(*) > 2000


Busca o ano de nascimento dos clientes e os classifica como: Nascidos antes de 1990 são velhos, nascidos entre 1990 e 1995 são jovens e nascidos depois de 1995 são crianças. Lista o nome do cliente e esta classificação:

>	SELECT NOME,
	CASE WHEN YEAR(data_de_nascimento) < 1990 THEN 'Velho' 
	WHEN YEAR(data_de_nascimento) >= 1990 
	AND	YEAR(data_de_nascimento) <= 1995 THEN 'Jovens' 
	ELSE 'Crianças' END
	FROM tabela_de_clientes


Busca ESTADO, LIMITE_DE_CREDITO(somando seus valores SUM() e atribuindo o nome da soma como LIMITE_TOTAL(AS) na tabela_de_clientes agrupando-os por ESTADO):
>	SELECT ESTADO, SUM(LIMITE_DE_CREDITO) AS LIMITE_TOTAL FROM tabela_de_clientes GROUP BY ESTADO;


Busca EMBALAGEM e seu maior preço na tabela produtos:
>	SELECT EMBALAGEM, MAX(PRECO_DE_LISTA) AS MAIOR_PRECO FROM tabela_de_Produtos GROUP BY EMBALAGEM;


Busca e conta quantos produtos existem com as respectivas embalagens existentes:
>	SELECT EMBALAGEM, COUNT(*) AS CONTADOR FROM tabela_de_produtos GROUP BY EMBALAGEM;


Busca e soma o limite de crédito de cada cliente agrupados por bairros do Rio de Janeiro:
>	SELECT BAIRRO, SUM(LIMITE_DE_CREDITO) AS LIMITE FROM tabela_de_clientes
	WHERE CIDADE = 'Rio de Janeiro' GROUP BY BAIRRO;


Busca e soma o limite de crédito de cada cliente agrupados por bairros e por estado também (agora todos estados):
>	SELECT ESTADO, BAIRRO, SUM(LIMITE_DE_CREDITO) AS LIMITE FROM tabela_de_clientes
	GROUP BY ESTADO, BAIRRO;


Busca e soma o limite de crédito de cada cliente agrupados por bairros do Rio de Janeiro e ordena por Bairro:
>	SELECT ESTADO, BAIRRO, SUM(LIMITE_DE_CREDITO) AS LIMITE FROM tabela_de_clientes
	WHERE CIDADE = 'Rio de Janeiro'
	GROUP BY ESTADO, BAIRRO
	ORDER BY BAIRRO;


Busca e soma o limite de crédito de cada cliente agrupados por estado (o nome atribuido a soma é LIMITE_DE_CREDITO):
>	SELECT ESTADO, SUM(LIMITE_DE_CREDITO) AS SOMA_LIMITE FROM tabela_de_clientes
	GROUP BY ESTADO;

Agora usaremos na próxima consulta a soma da consulta acima com o HAVING que vai filtrar a soma por um determinado 
valor :
>	SELECT ESTADO, SUM(LIMITE_DE_CREDITO) AS SOMA_LIMITE FROM tabela_de_clientes
	GROUP BY ESTADO HAVING SUM(LIMITE_DE_CREDITO) > 900000;


Busca a embalagem com maior e com menor preço:
>	SELECT EMBALAGEM, MAX(PRECO_DE_LISTA) AS MAIOR_PRECO,
	MIN(PRECO_DE_LISTA) AS MENOR_PRECO FROM tabela_de_produtos
	GROUP BY EMBALAGEM;


Busca a embalagem com maior e com menor preço e o HAVING filtra a soma dos preços:
>	SELECT EMBALAGEM, MAX(PRECO_DE_LISTA) AS MAIOR_PRECO,
	MIN(PRECO_DE_LISTA) AS MENOR_PRECO FROM tabela_de_produtos
	GROUP BY EMBALAGEM HAVING SUM(PRECO_DE_LISTA) <= 80;


Busca com filtro HAVING passando duas condições:
>	SELECT EMBALAGEM, MAX(PRECO_DE_LISTA) AS MAIOR_PRECO,
	MIN(PRECO_DE_LISTA) AS MENOR_PRECO FROM tabela_de_produtos
	GROUP BY EMBALAGEM HAVING SUM(PRECO_DE_LISTA) <= 80 AND MAX(PRECO_DE_LISTA) >= 5;


Busca com o comando CASE que permite que possa ser classificado cada registro da tabela:

>	SELECT NOME_DO_PRODUTO, PRECO_DE_LISTA,
	CASE
	   WHEN PRECO_DE_LISTA >= 12 THEN 'PRODUTO CARO'
	   WHEN PRECO_DE_LISTA >= 7 AND PRECO_DE_LISTA < 12 THEN 'PRODUTO EM CONTA'
	   ELSE 'PRODUTO BARATO'
	END AS STATUS_PRECO
	FROM tabela_de_produtos;

OBS.: A saida será o nome do produto, o seu respectivo preço e sua classificação de acordo com o CASE(STATUS_PRECO)
com o CASE foi possível classificar os produtos como CARO, BARATO ou EM CONTA conforme o valor do seu preço de lista.


Busca com o CASE como critério de agrupamento:

>	SELECT EMBALAGEM,
	CASE
	   WHEN PRECO_DE_LISTA >= 12 THEN 'PRODUTO CARO'
	   WHEN PRECO_DE_LISTA >= 7 AND PRECO_DE_LISTA < 12 THEN 'PRODUTO EM CONTA'
	   ELSE 'PRODUTO BARATO'
	END AS STATUS_PRECO, AVG(PRECO_DE_LISTA) AS PRECO_MEDIO
	FROM tabela_de_produtos
	WHERE sabor = 'Manga'
	GROUP BY EMBALAGEM,
	CASE
	   WHEN PRECO_DE_LISTA >= 12 THEN 'PRODUTO CARO'
	   WHEN PRECO_DE_LISTA >= 7 AND PRECO_DE_LISTA < 12 THEN 'PRODUTO EM CONTA'
	   ELSE 'PRODUTO BARATO'
	END
	ORDER BY EMBALAGEM;	

OBS.: A saida será o tipo da embalagem, o sua classificação de acordo com o CASE(STATUS_PRECO) e a sua classificação
de acordo com o CASE (PRECO_MEDIO)




**********************************************   JOIN   **************************************************************
LIMIT OFFSET

Busca conectando duas tabelas pelo campo em comum (MATRICULA):
>	SELECT * FROM tabela_de_vendedores A
	INNER JOIN notas_fiscais B
	ON A.MATRICULA = B.MATRICULA;


Busca aplicando agrupamentos ao resultado da consulta que conecta uma ou mais tabelas:
>	SELECT A.MATRICULA, A.NOME, COUNT(*) FROM
	tabela_de_vendedores A
	INNER JOIN notas_fiscais B
	ON A.MATRICULA = B.MATRICULA
	GROUP BY A.MATRICULA, A.NOME;


Busca cpf e nome da tabela_de_clientes(A), e na tabela notas_fiscais(B), busca todos clientes com mesmo cpf da 
tabela (A), porem do lado da tabela (A) buscaria todos os clientes existentes por causa do LEFT JOIN
e do lado (B) só os que tem a mesmo CPF do lado (A):

>	SELECT DISTINCT A.CPF, A.NOME, B.CPF FROM tabela_de_clientes A
	LEFT JOIN notas_fiscais B ON A.CPF = B.CPF

Busca todo cliente que na tabela (B) estiver o campo NULL:
>	SELECT DISTINCT A.CPF, A.NOME, B.CPF FROM tabela_de_clientes A
	LEFT JOIN notas_fiscais B ON A.CPF = B.CPF
	WHERE B.CPF IS NULL;


Busca juntando duas ou mais consultas, Desde que os campos selecionados sejam os mesmos:
>	SELECT DISTINCT BAIRRO FROM tabela_de_clientes
	UNION
	SELECT DISTINCT BAIRRO FROM tabela_de_vendedores;


Busca com UNION ALL -> não faz a seleção com um DISTINCT. As linhas se repetem se existirem em ambas as tabelas:
>	SELECT DISTINCT BAIRRO FROM tabela_de_clientes
	UNION ALL
	SELECT DISTINCT BAIRRO FROM tabela_de_vendedores;


Busca simulando o FULL JOIN, que não é suportado pelo MYSQL, usando o LEFT JOIN e RIGHT JOIN com UNION:

>	SELECT tabela_de_vendedores.BAIRRO,
	tabela_de_vendedores.NOME, DE_FERIAS,
	tabela_de_clientes.BAIRRO,
	tabela_de_clientes.NOME  FROM tabela_de_vendedores LEFT JOIN tabela_de_clientes
	ON tabela_de_vendedores.BAIRRO = tabela_de_clientes.BAIRRO
	UNION
	SELECT tabela_de_vendedores.BAIRRO,
	tabela_de_vendedores.NOME, DE_FERIAS,
	tabela_de_clientes.BAIRRO,
	tabela_de_clientes.NOME  FROM tabela_de_vendedores RIGHT JOIN tabela_de_clientes
	ON tabela_de_vendedores.BAIRRO = tabela_de_clientes.BAIRRO;

OBS.: A saída seria uma tabela com todos os clientes e todos os vendedores com bairros iguais ou diferentes(FULL JOIN).


Busca através de uma subconsulta todos os clientes onde o valor do campo Bairro se encontra no campo Bairro da 
tabela de vendedores:

>	SELECT * FROM tabela_de_clientes WHERE BAIRRO 
	IN (SELECT DISTINCT BAIRRO FROM tabela_de_vendedores);	

Busca o faturamento anual da empresa, levando em consideração que o valor financeiro das vendas consiste em 
multiplicar a quantidade pelo preço:

>	SELECT YEAR(DATA_VENDA), SUM(QUANTIDADE * PRECO) AS FATURAMENTO
	FROM notas_fiscais NF INNER JOIN itens_notas_fiscais INF 
	ON NF.NUMERO = INF.NUMERO
	GROUP BY YEAR(DATA_VENDA)	
	
SUBCONSULTA:
PERGUNTA: Como seria a consulta usando subconsulta que seria equivalente a:

	  SELECT CPF, COUNT(*) FROM notas_fiscais
	  WHERE YEAR(DATA_VENDA) = 2016
	  GROUP BY CPF
	  HAVING COUNT(*) > 2000;
RESPOSTA:

	SELECT X.CPF, X.CONTADOR FROM 
	(SELECT CPF, COUNT(*) AS CONTADOR FROM notas_fiscais
	WHERE YEAR(DATA_VENDA) = 2016
	GROUP BY CPF) X WHERE X.CONTADOR > 2000;


Busca aplicando uma consulta, em vez de sobre uma tabela, sobre outra consulta:
>	SELECT X.EMBALAGEM, X.PRECO_MAXIMO FROM 
	(SELECT EMBALAGEM, MAX(PRECO_DE_LISTA) AS PRECO_MAXIMO FROM tabela_de_produtos
	GROUP BY EMBALAGEM) X WHERE X.PRECO_MAXIMO >= 10;

OBS.: A saída seria o preço maximo de cada embalagem sendo ele maior ou igual a 10.


=======================	 FUNÇÕES PARA STRINGS EM S Q L  ==================================

Imprime uma coluna chamada RESULTADO tirando os espaços a esquerda da string:
>	SELECT LTRIM('    OLÁ') AS RESULTADO;


Imprime uma coluna chamada RESULTADO tirando os espaços a direita da string:
>	SELECT RTRIM('OLÁ     ') AS RESULTADO;


Imprime uma coluna chamada RESULTADO tirando todos os espaços da string:
>	SELECT TRIM('    OLÁ    ') AS RESULTADO;


Concatena strings na tabela RESULTADO:
>	SELECT CONCAT('OLÁ', ' ', 'TUDO BEM','?') AS RESULTADO;


Modifica a string para caixa alta:
>	SELECT UPPER('olá, tudo bem?') AS RESULTADO;


Modifica a string para caixa baixa:
>	SELECT LOWER('OLÁ, TUDO BEM?') AS RESULTADO;


Recorta a string a partir do char na sexta posição:
>	SELECT SUBSTRING('OLÁ, TUDO BEM?', 6) AS RESULTADO;


Concatena o NOME com o CPF(envolvido entre parenteses) da tabela de clientes:
>	SELECT CONCAT(NOME, ' (', CPF, ') ') AS RESULTADO FROM TABELA_DE_CLIENTES;


Imprime a data atual do computador:
>	SELECT CURDATE();


Imprime a hora atual do computador:
>	SELECT CURRENT_TIME();


Imprime a data e a hora atual do computador:
>	SELECT CURRENT_TIMESTAMP();


Imprime o dia correspondente a data atual do computador:
>	SELECT DAY(CURRENT_TIMESTAMP());

Imprime o mês correspondente a data atual do computador:
>	SELECT MONTH(CURRENT_TIMESTAMP());


Imprime o nome do mês correspondente a data atual do computador:
>	SELECT MONTHNAME(CURRENT_TIMESTAMP());


Imprime a diferença de dias entre a data atual e a data passada no parametro:
>	SELECT DATEDIFF(CURRENT_TIMESTAMP(), '2019-01-01') AS RESULTADO;


Imprime duas colunas(DIA_HOJE e RESULTADO): uma com a data atual e outra com intervalo de 5 dias acrescentados a data atual:
>	SELECT CURRENT_TIMESTAMP() AS DIA_HOJE
	, DATE_SUB(CURRENT_TIMESTAMP(), INTERVAL 5 DAY) AS RESULTADO;


Imprime quatro colunas( 1- DATA_VENDA: os dias que foram registradas vendas, 2- DIA: nome do dia da semana
						3- MES: nome do mes, 4- ANO: ano com 4 digitos):
>	SELECT DISTINCT DATA_VENDA,
	DAYNAME(DATA_VENDA) AS DIA, MONTHNAME(DATA_VENDA) AS MES
	, YEAR(DATA_VENDA) AS ANO FROM NOTAS_FISCAIS;


Busca o nome e a idade atual dos clientes:
>	SELECT NOME, TIMESTAMPDIFF (YEAR, DATA_DE_NASCIMENTO, CURDATE()) AS IDADE
	FROM  tabela_de_clientes;

Busca o nome do cliente e o endereço completo (Com rua, bairro, cidade e estado):
>	SELECT NOME, CONCAT(ENDERECO_1, ' ', BAIRRO, ' ', CIDADE, ' ', ESTADO) AS COMPLETO
	FROM tabela_de_clientes;

Busca o valor do imposto pago no ano de 2016 arredondando para o menor inteiro. Sendo que na tabela de notas fiscais
temos o valor do imposto, já na tabela de itens temos a quantidade e o faturamento:

>	SELECT YEAR(DATA_VENDA), FLOOR(SUM(IMPOSTO * (QUANTIDADE * PRECO))) 
	FROM notas_fiscais NF
	INNER JOIN itens_notas_fiscais INF ON NF.NUMERO = INF.NUMERO
	WHERE YEAR(DATA_VENDA) = 2016
	GROUP BY YEAR(DATA_VENDA);


Construoe um SQL cujo resultado seja, para cada cliente: “O cliente João da Silva faturou 120000 no ano de 2016”.
Somente para o ano de 2016:

>	SELECT CONCAT('O cliente ', TC.NOME, ' faturou ', 
	CAST(SUM(INF.QUANTIDADE * INF.preco) AS char (20))
	 , ' no ano ', CAST(YEAR(NF.DATA_VENDA) AS char (20))) AS SENTENCA FROM notas_fiscais NF
	INNER JOIN itens_notas_fiscais INF ON NF.NUMERO = INF.NUMERO
	INNER JOIN tabela_de_clientes TC ON NF.CPF = TC.CPF
	WHERE YEAR(DATA_VENDA) = 2016
	GROUP BY TC.NOME, YEAR(DATA_VENDA);



=======================	 FUNÇÕES MATEMÁTICAS EM S Q L  ==================================


Resolve uma expressão MATEMÁTICAS

Resolvendo uma opração matemática e armazenando em uma coluna com nome de RESULTADO:
SELECT (23+((25-2)/2)*45) AS RESULTADO; {saida: 540.500}


Arredonda para o maior valor inteiro:
SELECT CEILING(12.33333232323) AS RESULTADO; {saida: 13}


Arredonda para o maior valor inteiro se o valor apos a virgula for maior do que 5:
SELECT ROUND(12.7777232323) AS RESULTADO; {saida: 13}


???????
SELECT RAND() AS RESULTADO; {saida: 0.5384060847930667}


Seleciona NUMERO, QUANTIDADE E PRECO e cria uma coluna chamada faturamento que armazena: quantidade * preco :
SELECT NUMERO, QUANTIDADE, PRECO, QUANTIDADE * PRECO AS FATURAMENTO
 FROM ITENS_NOTAS_FISCAIS;


A mesma da de cima porem quantodade * preco arrendondado com duas casa decimais:
 SELECT NUMERO, QUANTIDADE, PRECO, ROUND(QUANTIDADE * PRECO, 2) AS FATURAMENTO
 FROM ITENS_NOTAS_FISCAIS;


Data e hora atual do computador:
 SELECT CURRENT_TIMESTAMP() AS RESULTADO;

Data e hora atual do computador concatenado com a frase:
 SELECT CONCAT('O dia de hoje é : ', CURRENT_TIMESTAMP()) AS RESULTADO;


Data e hora atual do computador concatenado com a frase e formatando para dia da semana com dia/mes/ano e numero da semana(18) 
 SELECT CONCAT('O dia de hoje é : ',
DATE_FORMAT(CURRENT_TIMESTAMP(),'%W, %d/%m/%Y - %U') ) AS RESULTADO; {saida: O dia de hoje é : wednesday, 27/04/2021 - 18}


 Converte para string e recorta e mostra o primeiro char:
 SELECT SUBSTRING(CONVERT(23.3, CHAR),1,1) AS RESULTADO;


 ==========================   RELATÓRIOS	========================================================


RELATÓRIO DE VENDAS POR TAMANHO DO PRODUTO:
 SELECT VENDA_TAMANHO.TAMANHO, VENDA_TAMANHO.ANO, VENDA_TAMANHO.QUANTIDADE,
ROUND((VENDA_TAMANHO.QUANTIDADE/VENDA_TOTAL.QUANTIDADE) * 100, 2) AS PARTICIPACAO FROM 
(SELECT TP.TAMANHO, YEAR(NF.DATA_VENDA) AS ANO, SUM(INF.QUANTIDADE) AS QUANTIDADE FROM 
TABELA_DE_PRODUTOS TP 
INNER JOIN ITENS_NOTAS_FISCAIS INF ON TP.CODIGO_DO_PRODUTO = INF.CODIGO_DO_PRODUTO
INNER JOIN NOTAS_FISCAIS NF ON NF.NUMERO = INF.NUMERO
WHERE YEAR(NF.DATA_VENDA) = 2016
GROUP BY TP.TAMANHO, YEAR(NF.DATA_VENDA)) AS VENDA_TAMANHO
INNER JOIN 
(SELECT YEAR(NF.DATA_VENDA) AS ANO, SUM(INF.QUANTIDADE) AS QUANTIDADE FROM 
TABELA_DE_PRODUTOS TP 
INNER JOIN ITENS_NOTAS_FISCAIS INF ON TP.CODIGO_DO_PRODUTO = INF.CODIGO_DO_PRODUTO
INNER JOIN NOTAS_FISCAIS NF ON NF.NUMERO = INF.NUMERO
WHERE YEAR(NF.DATA_VENDA) = 2016
GROUP BY YEAR(NF.DATA_VENDA)) AS VENDA_TOTAL
ON VENDA_TAMANHO.ANO = VENDA_TOTAL.ANO
ORDER BY VENDA_TAMANHO.QUANTIDADE DESC




CRIA UM RELATÓRIO QUE MOSTRA A PORCENTAGEM(COLUNA PARTICIPACAO) DE VENDAS DE UM DETERMINADO SABOR:
SELECT VENDA_SABOR.SABOR, VENDA_SABOR.ANO, VENDA_SABOR.QUANTIDADE,
ROUND((VENDA_SABOR.QUANTIDADE/VENDA_TOTAL.QUANTIDADE) * 100, 2) AS PARTICIPACAO FROM
(SELECT TP.SABOR, YEAR(NF.DATA_VENDA) AS ANO, SUM(INF.QUANTIDADE) AS QUANTIDADE FROM
TABELA_DE_PRODUTOS TP
INNER JOIN ITENS_NOTAS_FISCAIS INF ON TP.CODIGO_DO_PRODUTO = INF.CODIGO_DO_PRODUTO
INNER JOIN NOTAS_FISCAIS NF ON NF.NUMERO = INF.NUMERO
WHERE YEAR(NF.DATA_VENDA) = 2016
GROUP BY TP.SABOR, YEAR(NF.DATA_VENDA)) AS VENDA_SABOR
INNER JOIN
(SELECT YEAR(NF.DATA_VENDA) AS ANO, SUM(INF.QUANTIDADE) AS QUANTIDADE FROM
TABELA_DE_PRODUTOS TP
INNER JOIN ITENS_NOTAS_FISCAIS INF ON TP.CODIGO_DO_PRODUTO = INF.CODIGO_DO_PRODUTO
INNER JOIN NOTAS_FISCAIS NF ON NF.NUMERO = INF.NUMERO
WHERE YEAR(NF.DATA_VENDA) = 2016
GROUP BY YEAR(NF.DATA_VENDA)) AS VENDA_TOTAL
ON VENDA_SABOR.ANO = VENDA_TOTAL.ANO
ORDER BY VENDA_SABOR.QUANTIDADE DESC





SET foreign_key_checks = 1; /* desativar checagem de chaves estrangeiras deletar registros e ativar depois(valor 0 e 1)*/











