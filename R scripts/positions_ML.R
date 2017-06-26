library(SPARQL) # SPARQL querying package
library(ggmap) # package to show charts

# Step 1 - Set up preliminaries and define query
# Define the CENPAT-GILIA endpoint
endpoint <- "http://166.82.4.230:7200/repositories/CENPAT-LOD"

# create query statement
query <- "PREFIX geo-pos: <http://www.w3.org/2003/01/geo/wgs84_pos#>
PREFIX dwc: <http://rs.tdwg.org/dwc/terms/>
PREFIX dsw: <http://purl.org/dsw/>

SELECT ?lat ?long ?date
WHERE { 
?s a dwc:Occurrence.
?s dsw:toTaxon <http://www.cenpat-conicet.gob.ar/resource/taxon/Mirounga_leonina>.
?s dsw:atEvent ?event.
?event dsw:locatedAt ?loc.
?event dwc:verbatimEventDate ?date.
?loc geo-pos:lat  ?lat .
?loc geo-pos:long ?long
FILTER (?lat >= \"-58.4046\"^^xsd:decimal && ?lat <= \"-32.4483\"^^xsd:decimal)
FILTER (?long >= \"-69.6095\"^^xsd:decimal && ?long <= \"-52.631\"^^xsd:decimal)
}"

# Step 2 - Use SPARQL package to submit query and save results to a data frame
qd <- SPARQL(endpoint,query)
df <- qd$results

argentineseamap <- get_map(location = "argentine sea", zoom=5, maptype = "satellite")

g <- ggmap(argentineseamap) +geom_point(data = df, aes(x=long, y=lat), col="red",pch=20)

print(g)
