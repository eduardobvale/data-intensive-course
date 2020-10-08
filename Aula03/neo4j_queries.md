
#Query
MATCH (m:Movie {title: "The Matrix"})<-[:ACTED_IN]-(p:Person) RETURN p

#Query
MATCH (p:Person) WHERE p.born > 0  RETURN p.born ORDER BY p.born DESC   

#Query
MATCH (p:Person)-[a:ACTED_IN]->(m:Movie) RETURN p.name, a.roles, m.title

#Query
MATCH (p:Person {name: "Keanu Reeves"})-[a:ACTED_IN]->(m:Movie {title: "The Matrix"}) RETURN p.name, a.roles, m.title

#Query
MATCH (p:Person {name: "Laurence Fishburne"})-[a:ACTED_IN]->(m:Movie)
WHERE single(x IN a.roles WHERE x = "Morpheus")
RETURN m

#Query
MATCH (p:Person) WHERE p.born > 0  RETURN p ORDER BY p.born ASC  LIMIT 5

#Query
MATCH (hanks:Person{name: "Tom Hanks"})-[:ACTED_IN]->(m:Movie),
(atores:Person)-[:ACTED_IN]->(m)
WHERE
(hanks.born-atores.born) > 0
RETURN atores

#Query
MATCH (fox:Person{name: "Matthew Fox"})-[:ACTED_IN]->(m:Movie),
(atores:Person)-[:ACTED_IN]->(m)
WHERE
(fox.born-atores.born) > 0
RETURN atores.name, (fox.born-atores.born) 

#Query
MATCH (p:Person{name: "Tom Hanks"})-[:ACTED_IN]->(m:Movie)
RETURN m.title

#Query
MATCH (hanks:Person{name: "Tom Hanks"})-[:ACTED_IN]->(m:Movie)<-[:DIRECTED]-(dir:Person)
RETURN dir.name

#Query
MATCH (p:Person)-[acted:ACTED_IN]->(:Movie)
RETURN p.name, count(acted) as filmes
ORDER BY filmes DESC
LIMIT 10
