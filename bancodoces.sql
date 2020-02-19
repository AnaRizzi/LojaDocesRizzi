CREATE DATABASE DocesRizzi
USE DocesRizzi

CREATE TABLE Produtos (
codigo int primary key identity, /*identity gera o número automaticamente*/
nome varchar(30) not null unique,
sabores varchar(50) not null,
peso float(53) not null, /*float(24) ou float(53) = 4 ou 8 bytes*/
valor_custo numeric(5,2) not null,
valor_venda numeric(5,2) not null,
)

SELECT * FROM Produtos

INSERT INTO Produtos (nome,sabores,peso,valor_custo,valor_venda) VALUES('Brigadeiro', 'tradicional, ninho, morango', 20, 0.60, 2.00) 


CREATE PROCEDURE cadastroProd
@nome varchar(30),
@sabores varchar(50),
@peso float(53),
@valor_custo numeric(5,2),
@valor_venda numeric(5,2)
AS
INSERT INTO Produtos VALUES (@nome, @sabores, @peso, @valor_custo, @valor_venda)

EXECUTE cadastroProd
'Brownie', 'chocolate, nozes e coco', '70', 1.60, 4



CREATE TABLE Ingredientes(
codigo int primary key identity,
nome varchar(20) not null unique,
marca varchar(20) not null,
preco numeric(5,2) not null,
tamanho varchar(20) not null,
estoque int not null,
)

SELECT * FROM Ingredientes

INSERT INTO Ingredientes (nome, marca, preco, tamanho, estoque) VALUES('Leite condensado', 'Nestlé', 4.50, '395 g', 10)
INSERT INTO Ingredientes (nome, marca, preco, tamanho, estoque) VALUES('cacau em pó', 'Imperial (mercadão)', 2.50, '100 g', 2)





CREATE TABLE Ingredientes_produtos(
codigo_produto int foreign key references Produtos(codigo) not null,
codigo_ingrediente int foreign key references Ingredientes(codigo) not null,
quantidade_ingrediente varchar(15) not null,
PRIMARY KEY (codigo_produto, codigo_ingrediente)
)

SELECT * FROM Ingredientes_produtos


INSERT INTO Ingredientes_produtos (codigo_produto, codigo_ingrediente, quantidade_ingrediente) VALUES(1, 1, '1 lata')
INSERT INTO Ingredientes_produtos (codigo_produto, codigo_ingrediente, quantidade_ingrediente) VALUES(1, 2, '30g (1 1/2 col)')
INSERT INTO Ingredientes_produtos (codigo_produto, codigo_ingrediente, quantidade_ingrediente) VALUES(2, 1, '2 latas')


CREATE VIEW QuantidadeIng
AS
SELECT p.nome AS Produto, ing.nome AS Ingrediente, ingp.quantidade_ingrediente AS Quantidade FROM Produtos AS p
INNER JOIN Ingredientes_produtos AS ingp ON p.codigo = ingp.codigo_produto
INNER JOIN Ingredientes AS ing ON ingp.codigo_ingrediente = ing.codigo

SELECT * FROM QuantidadeIng ORDER BY Ingrediente




CREATE TABLE Clientes(
codigo int primary key identity,
nome varchar(20) not null,
telefone varchar(11),
email varchar(40),
observacao varchar(100),
)

SELECT * FROM Clientes

INSERT INTO Clientes (nome, telefone, observacao) VALUES ('Mikhail', '11980116873', 'o primeiro cliente e ajudante de vendas')



CREATE TABLE Pedidos(
codigo_pedido int primary key identity(1,1),
codigo_cliente int foreign key references Clientes(codigo) not null,
codigo_produto int foreign key references Produtos(codigo) not null,
quantidade int not null,
desconto numeric(5,2),
obs_pagamento varchar(100) not null,
data_pedido date not null,
data_entrega date not null,
)

SELECT * FROM Pedidos

SELECT * FROM Pedidos WHERE codigo_pedido=5

INSERT INTO Pedidos (codigo_cliente, codigo_produto, quantidade, desconto, obs_pagamento, data_pedido, data_entrega) VALUES (1, 1, 5, 2.00, 'vai pagar algum dia', '12-05-2019', '12-20-2019')





CREATE VIEW PedidosCompletos
AS
SELECT ped.codigo_pedido AS Codigo, 
c.nome AS Cliente, 
prod.nome AS Produto,
ped.quantidade AS Quantidade,
ped.desconto AS Desconto,
ped.obs_pagamento AS Pagamento,
ped.data_pedido AS Data_Pedido,
ped.data_entrega AS Data_Entrega,
Total=prod.valor_venda*ped.quantidade-ped.desconto
FROM Clientes AS c
INNER JOIN Pedidos AS ped ON c.codigo = ped.codigo_cliente
INNER JOIN Produtos AS prod ON ped.codigo_produto = prod.codigo

SELECT * FROM PedidosCompletos

SELECT * FROM PedidosCompletos WHERE Cliente = 'ana' AND Produto LIKE '%'


SELECT * FROM QuantidadeIng ORDER BY Ingrediente


CREATE TABLE Usuario (
codigo int primary key identity,
usuario varchar(20) not null unique,
senha varchar(20) not null
)

INSERT INTO Usuario (usuario, senha) VALUES ('admin', '1234567')

SELECT * FROM Usuario


