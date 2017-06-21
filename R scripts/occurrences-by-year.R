library(SPARQL) # SPARQL querying package
library(ggplot2) # package to show charts

# Step 1 - Set up preliminaries and define query
# Define the CENPAT-GILIA endpoint
endpoint <- "http://166.82.4.230:7200/repositories/CENPAT-LOD"

# create query statement
query <- "PREFIX dwc: <http://rs.tdwg.org/dwc/terms/>
PREFIX dsw: <http://purl.org/dsw/>
SELECT ?year (COUNT(?s) as ?count)  
{ 
?s a dwc:Event.
?s dwc:verbatimEventDate ?date
}
GROUP BY (year(?date) AS ?year)
ORDER BY ASC(?year)"

# Step 2 - Use SPARQL package to submit query and save results to a data frame
qd <- SPARQL(endpoint,query)
df <- qd$results

# Step 4 - Plot temporal series

g <- ggplot(df, aes(year, count)) + geom_line() + xlab("Year") + ylab("Number of Occurrences")

print(g)
