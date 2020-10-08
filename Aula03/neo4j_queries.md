
## C1
```
MATCH (m:Movie {title: "The Matrix"})<-[:ACTED_IN]-(p:Person) RETURN p
```
## C2
```
MATCH (p:Person) WHERE p.born > 0  RETURN p.born ORDER BY p.born DESC   
```
## C3
```
MATCH (p:Person)-[a:ACTED_IN]->(m:Movie) RETURN p.name, a.roles, m.title
```
## C4
```
MATCH (p:Person {name: "Keanu Reeves"})-[a:ACTED_IN]->(m:Movie {title: "The Matrix"}) 
WHERE single(x IN a.roles WHERE x = "Neo")
RETURN p.name, a.roles, m.title
```
## C5
```
MATCH (p:Person {name: "Laurence Fishburne"})-[a:ACTED_IN]->(m:Movie)
WHERE single(x IN a.roles WHERE x = "Morpheus")
RETURN m
```
## C6
```
MATCH (p:Person) WHERE p.born > 0  RETURN p ORDER BY p.born ASC  LIMIT 5
```
## C7
```
MATCH (hanks:Person{name: "Tom Hanks"})-[:ACTED_IN]->(m:Movie),
(atores:Person)-[:ACTED_IN]->(m)
WHERE
hanks.born > atores.born
RETURN atores
```
## C8
```
MATCH (fox:Person{name: "Matthew Fox"})-[:ACTED_IN]->(m:Movie),
(atores:Person)-[:ACTED_IN]->(m)
WHERE
fox.born > atores.born
RETURN atores.name, (fox.born-atores.born) 
```
## C9
```
MATCH (p:Person{name: "Tom Hanks"})-[:ACTED_IN]->(m:Movie)
RETURN m.title
```
## C10
```
MATCH (hanks:Person{name: "Tom Hanks"})-[:ACTED_IN]->(m:Movie)<-[:DIRECTED]-(dir:Person)
RETURN dir.name
```
## EXTRA
```
MATCH (p:Person)-[acted:ACTED_IN]->(:Movie)
RETURN p.name, count(acted) as filmes
ORDER BY filmes DESC
LIMIT 10
```
