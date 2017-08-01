library(SPARQL) # SPARQL querying package
library(ggplot2) # package to show charts

# Step 1 - Set up preliminaries and define query
# Define the CENPAT-GILIA endpoint
endpoint <- "http://crowd.fi.uncoma.edu.ar:3333/repositories/BIO_CNP_GILIA"

# create query statement
query <- "PREFIX dwc: <http://rs.tdwg.org/dwc/terms/>
PREFIX dsw: <http://purl.org/dsw/>
SELECT ?s_name (COUNT(?s) as ?count)  
{ 
?s a dwc:Occurrence.
?s dsw:toTaxon ?taxon.
?taxon dwc:class ?class.
?taxon dwc:scientificName ?s_name. 
FILTER regex ( STR (?class ), \"Mammalia\")
}
GROUP BY ?s_name"

# Step 2 - Use SPARQL package to submit query and save results to a data frame
qd <- SPARQL(endpoint,query)
df <- qd$results

# Step 4 - Plot some data
g <- ggplot(df, aes(x=s_name,y=count))+geom_bar(stat="identity") +coord_flip()+ggtitle("Amount of mammals in the dataset")

print(g)
