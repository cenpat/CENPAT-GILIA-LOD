library(SPARQL) # SPARQL querying package
library(stargazer)

# Step 1 - Set up preliminaries and define query
# Define the CENPAT-GILIA endpoint
endpoint <- "http://crowd.fi.uncoma.edu.ar:3333/repositories/BIO_CNP_GILIA"

# create query statement
query <- "PREFIX dbo: <http://dbpedia.org/ontology/>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX dwc: <http://rs.tdwg.org/dwc/terms/>
PREFIX txn: <http://lod.taxonconcept.org/ontology/txn.owl#>
PREFIX dsw: <http://purl.org/dsw/>
SELECT ?scname ?eol_page ?c_status 
WHERE {
?s a dwc:Taxon.
?s dwc:scientificName ?scname.
?s txn:hasEOLPage ?eol_page.
?s owl:sameAs ?resource .
SERVICE <http://dbpedia.org/sparql> {
?resource dbo:conservationStatus ?c_status.
} 
}"

# Step 2 - Use SPARQL package to submit query and save results to a data frame
qd <- SPARQL(endpoint,query)
df <- qd$results

stargazer(df, type = 'text', summary = FALSE, rownames = FALSE, out = 'out.txt')
