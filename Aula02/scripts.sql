-- Database: education-institution

-- DROP DATABASE "education-institution";

CREATE DATABASE "education-institution"
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'en_US.utf8'
    LC_CTYPE = 'en_US.utf8'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;


-- SCHEMA: public

-- DROP SCHEMA public ;

CREATE SCHEMA public
    AUTHORIZATION postgres;

COMMENT ON SCHEMA public
    IS 'standard public schema';

GRANT ALL ON SCHEMA public TO PUBLIC;

GRANT ALL ON SCHEMA public TO postgres;


--Departamento
CREATE TABLE public."Departamento"
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY,
    codigo text NOT NULL,
    nome text NOT NULL,
    sigla text NOT NULL,
    email text,
    telefone text,
    PRIMARY KEY (id)
);

ALTER TABLE public."Departamento"
    OWNER to postgres;

--Curso
CREATE TABLE public."Curso"
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY,
    nome text NOT NULL,
    sigla text NOT NULL,
    site text,
    telefone text,
    id_departamento integer,
    PRIMARY KEY (id),
    FOREIGN KEY (id_departamento)
        REFERENCES public."Departamento" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
);

ALTER TABLE public."Curso"
    OWNER to postgres;


--Disciplina
CREATE TABLE public."Disciplina"
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY,
    nome text NOT NULL,
    sigla text NOT NULL,
    programa text NOT NULL,
    ementa text NOT NULL,
    bibilografia text NOT NULL,
    carga_horaria text NOT NULL,
    PRIMARY KEY (id)
);

ALTER TABLE public."Disciplina"
    OWNER to postgres;

-- Table: public.Aluno

-- DROP TABLE public."Aluno";

CREATE TABLE public."Aluno"
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    cpf numeric NOT NULL,
    rg numeric NOT NULL,
    data_nascimento date NOT NULL,
    primeiro_nome text COLLATE pg_catalog."default" NOT NULL,
    nome_intermediario text COLLATE pg_catalog."default" NOT NULL,
    sobrenome text COLLATE pg_catalog."default" NOT NULL,
    endereco text COLLATE pg_catalog."default",
    id_curso integer,
    CONSTRAINT "Aluno_pkey" PRIMARY KEY (id),
    CONSTRAINT "Aluno_id_curso_fkey" FOREIGN KEY (id_curso)
        REFERENCES public."Curso" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE public."Aluno"
    OWNER to postgres;

-- Table: public.Telefone

-- DROP TABLE public."Telefone";

CREATE TABLE public."Telefone"
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    telefone text COLLATE pg_catalog."default" NOT NULL,
    id_aluno integer,
    CONSTRAINT "Telefone_pkey" PRIMARY KEY (id),
    CONSTRAINT "Telefone_id_aluno_fkey" FOREIGN KEY (id_aluno)
        REFERENCES public."Aluno" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE public."Telefone"
    OWNER to postgres;


-- Table: public.Oferece

-- DROP TABLE public."Oferece";

CREATE TABLE public."Oferece"
(
    id_curso integer,
    id_disciplina integer,
    tipo text COLLATE pg_catalog."default",
    CONSTRAINT "Oferece_id_curso_fkey" FOREIGN KEY (id_curso)
        REFERENCES public."Curso" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "Oferece_id_disciplina_fkey" FOREIGN KEY (id_disciplina)
        REFERENCES public."Disciplina" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE public."Oferece"
    OWNER to postgres;


-- Table: public.PreRequisito

-- DROP TABLE public."PreRequisito";

CREATE TABLE public."PreRequisito"
(
    id_disciplina integer,
    id_disciplina_pre_requisito integer,
    CONSTRAINT "PreRequisito_id_disciplina_fkey" FOREIGN KEY (id_disciplina)
        REFERENCES public."Disciplina" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "PreRequisito_id_disciplina_pre_requisito_fkey" FOREIGN KEY (id_disciplina_pre_requisito)
        REFERENCES public."Disciplina" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE public."PreRequisito"
    OWNER to postgres;

-- Table: public.Matricula

-- DROP TABLE public."Matricula";

CREATE TABLE public."Matricula"
(
    id_aluno integer,
    id_disciplina integer,
    CONSTRAINT "Matricula_id_aluno_fkey" FOREIGN KEY (id_aluno)
        REFERENCES public."Aluno" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "Matricula_id_disciplina_fkey" FOREIGN KEY (id_disciplina)
        REFERENCES public."Disciplina" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE public."Matricula"
    OWNER to postgres;

-- Table: public.Conclusao

-- DROP TABLE public."Conclusao";

CREATE TABLE public."Conclusao"
(
    id_aluno integer,
    id_disciplina integer,
    CONSTRAINT "Conclusao_id_aluno_fkey" FOREIGN KEY (id_aluno)
        REFERENCES public."Aluno" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "Conclusao_id_disciplina_fkey" FOREIGN KEY (id_disciplina)
        REFERENCES public."Disciplina" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE public."Conclusao"
    OWNER to postgres;

--- DATA

INSERT INTO public."Departamento"(
	codigo, nome, sigla, email, telefone)
	VALUES ( 1, 'Engenharia', 'ENG', 'eng@uni.com', '11990011003');
	
INSERT INTO public."Departamento"(
	codigo, nome, sigla, email, telefone)
	VALUES ( 2, 'Belas Artes', 'ART', 'artes@uni.com', '11992011303');
	
INSERT INTO public."Departamento"(
	codigo, nome, sigla, email, telefone)
	VALUES ( 3, 'Ciências', 'CIE', 'ciencias@uni.com', '11992011503');


SELECT * FROM public."Departamento"
ORDER BY id ASC 


INSERT INTO public."Curso"(
	nome, sigla, site, telefone, id_departamento)
	VALUES ('Engenharia Civil', 'ENGCIV', 'engcivil.uni.com', '', 1);
	
INSERT INTO public."Curso"(
	nome, sigla, site, telefone, id_departamento)
	VALUES ('Pintura', 'ARTPINT', 'pintura.uni.com', '', 2);
	
INSERT INTO public."Curso"(
	nome, sigla, site, telefone, id_departamento)
	VALUES ('Matemática', 'CIEMAT', 'mat.uni.com', '', 3);

SELECT * FROM public."Curso"
ORDER BY id ASC 



INSERT INTO public."Disciplina"(
	nome, sigla, programa, ementa, bibilografia, carga_horaria)
	VALUES ('Calculo I', 'CALCI', 
			'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod', 
			'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod', 
			'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod', '80h');
			
INSERT INTO public."Disciplina"(
	nome, sigla, programa, ementa, bibilografia, carga_horaria)
	VALUES ('Calculo II', 'CALCII', 
			'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod', 
			'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod', 
			'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod', '90h');

INSERT INTO public."Disciplina"(
	nome, sigla, programa, ementa, bibilografia, carga_horaria)
	VALUES ('Historia da Arte', 'CALCII', 
			'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod', 
			'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod', 
			'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod', '90h');
			
			
INSERT INTO public."Disciplina"(
	nome, sigla, programa, ementa, bibilografia, carga_horaria)
	VALUES ('Epistemologia', 'EPIST', 
			'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod', 
			'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod', 
			'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod', '90h');
			

			
INSERT INTO public."Disciplina"(
	nome, sigla, programa, ementa, bibilografia, carga_horaria)
	VALUES ('Algebra Linear', 'ALGLIN', 
			'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod', 
			'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod', 
			'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod', '100h');
			
			
INSERT INTO public."Disciplina"(
	nome, sigla, programa, ementa, bibilografia, carga_horaria)
	VALUES ('Matematica Discreta', 'MATDIS', 
			'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod', 
			'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod', 
			'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod', '70h');


INSERT INTO public."Aluno"(
	cpf, rg, data_nascimento, primeiro_nome, nome_intermediario, sobrenome, endereco, id_curso)
	VALUES (3251460854, 
			5466986291,
			'1969-08-22', 
			'Sidonnie', 
			'Curnucke', 
			'Hulks', 
			'20140 International Circle', 1);
			
INSERT INTO public."Aluno"(
	cpf, rg, data_nascimento, primeiro_nome, nome_intermediario, sobrenome, endereco, id_curso)
	VALUES (0649383613, 
			4242664966,
			'2000-02-17', 
			'Fabe', 
			'Sigars', 
			'Biggs', 
			'4492 Dottie Road', 2);



INSERT INTO public."Oferece"(
	id_curso, id_disciplina, tipo)
	VALUES (1, 1, 'OBRIGATORIA');
	
INSERT INTO public."Oferece"(
	id_curso, id_disciplina, tipo)
	VALUES (1, 2, 'OPTATIVA');
	
INSERT INTO public."Oferece"(
	id_curso, id_disciplina, tipo)
	VALUES (2, 3, 'OBRIGATORIA');
	
INSERT INTO public."Oferece"(
	id_curso, id_disciplina, tipo)
	VALUES (2, 4, 'OPTATIVA');

INSERT INTO public."Oferece"(
	id_curso, id_disciplina, tipo)
	VALUES (3, 1, 'OPTATIVA');

INSERT INTO public."Oferece"(
	id_curso, id_disciplina, tipo)
	VALUES (3, 2, 'OPTATIVA');

INSERT INTO public."Oferece"(
	id_curso, id_disciplina, tipo)
	VALUES (3, 5, 'OBRIGATORIA');
	
INSERT INTO public."Oferece"(
	id_curso, id_disciplina, tipo)
	VALUES (3, 6, 'OBRIGATORIA');

INSERT INTO public."PreRequisito"(
	id_disciplina, id_disciplina_pre_requisito)
	VALUES (2, 1);
	
INSERT INTO public."PreRequisito"(
	id_disciplina, id_disciplina_pre_requisito)
	VALUES (4, 3);


INSERT INTO public."Conclusao"(
	id_aluno, id_disciplina)
	VALUES (1, 1);
	
INSERT INTO public."Conclusao"(
	id_aluno, id_disciplina)
	VALUES (2, 3);

INSERT INTO public."Matricula"(
	id_aluno, id_disciplina)
	VALUES (1, 2);

INSERT INTO public."Matricula"(
	id_aluno, id_disciplina)
	VALUES (2, 4);

INSERT INTO public."Telefone"(
	telefone, id_aluno)
	VALUES ('11991102920', 1);

INSERT INTO public."Telefone"(
	telefone, id_aluno)
	VALUES ('11982281819', 2);


-- CONSUlTAS

-- Alunos e seus cursos realizados

SELECT aluno.id,
cpf, 
rg, 
data_nascimento,
EXTRACT(YEAR from AGE(data_nascimento)) as idade,
primeiro_nome 
|| ' ' 
|| nome_intermediario 
|| ' ' 
|| sobrenome AS nome, 
curso.nome as curso
	FROM public."Aluno" as aluno
	JOIN public."Telefone" as tel 
	ON tel.id_aluno = aluno.id
    JOIN public."Curso" as curso 
	ON aluno.id_curso = curso.id
	GROUP BY
    aluno.id, curso.id;

-- conclusoes

SELECT id_aluno, aluno.primeiro_nome, disc.nome, disc.sigla
	FROM public."Conclusao"
	JOIN public."Aluno" as aluno
	ON aluno.id = id_aluno
	JOIN public."Disciplina" as disc
	ON disc.id = id_disciplina;
	


-- matriculas

SELECT id_aluno, aluno.primeiro_nome, disc.nome, disc.sigla
	FROM public."Matricula"
	JOIN public."Aluno" as aluno
	ON aluno.id = id_aluno
	JOIN public."Disciplina" as disc
	ON disc.id = id_disciplina;
	
-- curso


SELECT curso.id,
curso.nome,
curso.sigla,
curso.site,
curso.telefone,
dep.nome || '-' || dep.sigla as departamento
	FROM public."Curso" as curso
	JOIN public."Departamento" as dep
	ON curso.id_departamento = dep.id


-- Departamento
SELECT id, codigo, nome, sigla, email, telefone
	FROM public."Departamento";


-- Disciplinas por curso

SELECT disc.id,
curso.nome as curso,
ofer.tipo,
disc.nome,
disc.sigla,
disc.programa,
disc.ementa,
disc.bibilografia,
disc.carga_horaria
	FROM public."Disciplina" as disc
	JOIN public."Oferece" as ofer
	ON ofer.id_disciplina = disc.id
	JOIN public."Curso" as curso
	ON curso.id = ofer.id_curso
