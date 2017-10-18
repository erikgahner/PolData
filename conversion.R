# Load package
library("rio")

# Concert to csv
convert("PolData.xlsx", "data.csv")

# Concert to Rdata
convert("PolData.xlsx", "PolData.Rdata")