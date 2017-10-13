# Load package
library("rio")

# Import Excel data
pd <- import("PolData.xlsx")

# Export to csv
export(pd, "PolData.csv")

# Export to Rdata
export(pd, "PolData.Rdata")
