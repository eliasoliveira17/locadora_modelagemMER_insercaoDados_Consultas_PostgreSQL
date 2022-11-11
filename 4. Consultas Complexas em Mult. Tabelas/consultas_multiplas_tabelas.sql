-- Encontrar filmes estrelado por determinado ator
SELECT f.titulo as "Título", g.genero as "Gênero", af.personagem as "Personagem"
FROM filmes as f, generos as g, atores_filme as af, atores as a
WHERE f.id_genero = g.id and af.id_filme = f.id and af.id_ator = a.id and
		a.nome = 'Angelina Jolie';

-- Encontrar filmes estrelados por atores em gêneros específicos
SELECT f.titulo as "Título", g.genero as "Gênero", a.nome as "Ator", af.personagem as "Personagem"
FROM filmes as f, generos as g, atores_filme as af, atores as a
WHERE f.id_genero = g.id and af.id_filme = f.id and af.id_ator = a.id and
		g.genero = 'Guerra';
		
-- Encontrar filmes estrelados por atores e gêneros específicos
SELECT f.titulo as "Título", g.genero as "Gênero", a.nome as "Ator", af.personagem as "Personagem"
FROM filmes as f, generos as g, atores_filme as af, atores as a
WHERE f.id_genero = g.id and af.id_filme = f.id and af.id_ator = a.id and
		g.genero = 'Guerra' and a.nome = 'Brad Pitt';

-- Verificar empréstimos por todos os clientes
SELECT e.id, c.nome as "Nome", c.sobrenome as "Sobrenome", e.data as "Data", f.titulo as "Título", g.genero as "Gênero"
FROM emprestimos as e, clientes as c, filmes as f, generos as g, dvds as d, filmes_emprestimo as fe
WHERE e.id_cliente = c.id and f.id_genero = g.id and fe.id_emprestimo = e.id and fe.id_dvd = d.id and f.id = d.id_filme;

-- Verificar devoluções por todos os clientes
SELECT de.id, c.nome as "Nome", c.sobrenome as "Sobrenome", de.data as "Data Devolução", f.titulo as "Título", g.genero as "Gênero"
FROM emprestimos as e, 
	clientes as c, 
	filmes as f, 
	generos as g, 
	dvds as d, 
	filmes_emprestimo as fe,
	devolucoes as de,
	filmes_devolucao as fd
WHERE fd.id_filme_emprestimo = fe.id and
	 fd.id_devolucao = de.id and
	 f.id_genero = g.id and
	 e.id_cliente = c.id and
	 d.id_filme = f.id and
	 fe.id_emprestimo = e.id and
	 fe.id_dvd = d.id;

-- Verificar valor da locação por cliente
SELECT e.id, c.nome as "Nome", c.sobrenome as "Sobrenome", sum(f.valor) as "Valor da Locação"
FROM emprestimos as e, 
	filmes_emprestimo as fe, 
	clientes as c, 
	filmes as f, 	
	dvds as d, 
	devolucoes as de,
	filmes_devolucao as fd
WHERE e.id_cliente = c.id and 
	fe.id_emprestimo = e.id and 
	fe.id_dvd = d.id and
	fd.id_devolucao = de.id and
	fd.id_filme_emprestimo = fe.id and
	f.id = d.id_filme
GROUP BY e.id, c.nome, c.sobrenome;