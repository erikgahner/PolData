# getwd()

download.file(url =  "https://raw.githubusercontent.com/spdx/license-list-data/main/json/licenses.json",
              destfile = "spdx_licenses.json")

spdx_licenses_1_v <- scan(
  file="spdx_licenses.json",
  sep="\n",
  what="character"
  )

spdx_licenses_2_v <- paste0(spdx_licenses_1_v, collapse = "")

# There is currently only one license with empty "seeAlso" slot, which needs to be changed
# (otherwise the rest fails)
spdx_licenses_3_v <- 
  gsub(pattern = '"seeAlso": [],',
     replacement =  '"seeAlso": [""],',
     x = spdx_licenses_2_v,
     fixed = T)

spdx_licenses_1_df <- dplyr::bind_rows(
  lapply(rjson::fromJSON(spdx_licenses_3_v)[2]$licenses, as.data.frame)
  )

# The above duplicates licenses that have various values for the seeAlso slot
# FIXME: For those duplicates, we keep only the first seeAlso value
#  (still, in a number of cases, the additional "seeAlso" slot is just the same page at archive.org)
spdx_licenses_2_df <- dplyr::distinct(
  spdx_licenses_1_df,
  # Variables for checking uniqueness; this list does not include "seeAlso":
  reference, isDeprecatedLicenseId, detailsUrl, referenceNumber, name, licenseId, isOsiApproved, isFsfLibre, 
  .keep_all = TRUE # Keep first value of "seeAlso"
  )

write.csv(spdx_licenses_2_df, 
          file = "spdx_licenses.csv",
          row.names = FALSE
          )
