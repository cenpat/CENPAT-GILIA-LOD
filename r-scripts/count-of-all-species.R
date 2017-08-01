library(SPARQL) # SPARQL querying package
library(stargazer) # to show the output in table format

# Step 1 - Set up preliminaries and define query
# Define the CENPAT-GILIA endpoint
endpoint <- "http://crowd.fi.uncoma.edu.ar:3333/repositories/BIO_CNP_GILIA"

# create query statement
query <- "PREFIX dwc: <http://rs.tdwg.org/dwc/terms/>
PREFIX dsw: <http://purl.org/dsw/>

SELECT ?scname (COUNT(?s) AS ?observations) 
{ 
?s a dwc:Occurrence.
?s dsw:toTaxon ?taxon.
?taxon dwc:scientificName ?scname
}
GROUP BY ?scname
ORDER BY DESC(COUNT(?s))"

# Step 2 - Use SPARQL package to submit query and save results to a data frame
qd <- SPARQL(endpoint,query)
df <- qd$results
#Step 3 - Display the result in table format using the package  stargazer

stargazer(df, type = 'text', summary = FALSE, rownames = FALSE, out = 'out.txt')
