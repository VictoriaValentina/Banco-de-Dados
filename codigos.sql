create database sistema;
use sistema;

create table cad_cidade(
	codigo int(2) auto_increment primary key not null, 
	nome varchar(30) not null, 
	uf varchar(2) not null);

insert into cad_cidade (nome, uf)
				values ('Curitiba', 'PR'),
					   ('Rio de Janeiro', 'RJ'),
                       ('Ponta Grossa', 'PR'),
                       ('São Paulo', 'SP'),
                       ('Ribeirão', 'SP');

select * from cad_cidade;
                       
describe cad_cidade;

alter table cad_cidade rename cidade;

select * from cidade;

select * from cidade where uf = 'SP';

create table funcionario (
	codigo int(3) auto_increment primary key not null,
    nome varchar(30) not null,
    endereco varchar(40) not null,
    numero int(6) not null,
    salario decimal(6,2) not null,
    cod_cidade int(2) not null);

alter table funcionario add (sexo char(1));

select * from funcionario;

insert into funcionario (nome, endereco, numero, salario, cod_cidade, sexo)
				values  ('Pedro', 'Rua Flores', 30, 1500, 2, 'M'),
						('Maria', 'Av Brasil', 400, 1960.70, 1, 'F'),
                        ('José', 'Rua do João', 759, 3800, 4, 'F'),
                        ('Marco', 'Av Santa Rita', 2, 3450.50, 2, 'M');

select nome, sexo from funcionario;

select * from funcionario where salario > 2000;

select * from funcionario where salario < 1500 and sexo = 'M';

select * from funcionario order by salario asc;

select * from funcionario where salario between 2000 and 3000; 

select * from funcionario where nome like 'm%';

select * from funcionario where nome like '%a%';

alter table funcionario add setor varchar(10);

update funcionario set setor = 'producao';

select * from funcionario;
select * from cidade;

update funcionario set setor = 'gerente' where codigo = 3;

update funcionario set nome = 'Felipe', setor = 'CEO' where codigo = 4;

delete from funcionario where codigo < 3;

delete from cidade where uf = 'SP';

alter table funcionario add foreign key (cod_cidade) references cidade (uf);

select * from funcionario as a join cidade as b on a.estado = b.uf;

alter table funcionario add estado varchar(2);

update funcionario set estado = 'RJ' where codigo = 3 or codigo = 4;

select avg (salario) as 'Media do salario' from funcionario;

select count(nome) as 'Name', sum(salario) as 'Soma dos salarios' from funcionario;

select count(nome) from cidade;

insert into funcionario (nome, endereco, numero, salario, cod_cidade, sexo, setor, estado)
				values  ('Pedro', 'Rua Flores', 30, 1500, 2, 'M', 'gerente', 'SP'),
						('Maria', 'Av Brasil', 400, 1960.70, 1, 'F', 'gerente', 'SP');


-- aula 6 --


delimiter $$
create procedure func_minimo (sal decimal)
select count(*) from funcionario where salario < sal;
$$

call func_minimo(5000);

delimiter $$
create procedure func_salario (id smallint)
select * from funcionario where codigo = id
$$

call func_salario(3);

delimiter $$
create procedure aumento()
update funcionario set salario = (salario * 1.1) where codigo > 0;
$$

select * from funcionario;
call aumento()

select * from funcionario;

drop procedure func_salario;

delimiter $$
create function soma (a int, b int)
returns int
return a + b ;
$$

select soma(3,4);
select soma(8,2) as 'Soma';

delimiter $$
create function salario (id smallint)
returns decimal(6,2)
return (select salario from funcionario where codigo = id);
$$

select salario (3);

delimiter $$
create function func_sexo (sex char)
returns int
return (select count(*) from funcionario where sexo = sex);
$$

drop function func_sexo;

select func_sexo ('F');

drop function soma;

create table backup (
	cod int(3) auto_increment primary key not null,
    nome varchar(30) not null,
    salario decimal(6,2)
    );
    
show tables;

delimiter $$
create trigger faz_backup before delete
on funcionario
for each row
begin
insert into backup (nome, salario)
			values (old.nome, old.salario);
end
$$ 

delete from funcionario where codigo = 3;

select * from funcionario;

select * from backup; 

