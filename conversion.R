# Load package
library("rio")

# Concert to csv
convert("PolData.xlsx", "PolData.csv")

# Concert to Rdata
convert("PolData.xlsx", "PolData.Rdata")