# Dataset Card – AgriYield

## 1. Dataset Information

- **Project:** AgriYield – Crop Yield Analysis and Agricultural Decision Support System
- **Dataset name:** FAOSTAT Crops and Livestock Products (QCL)
- **Source:** Food and Agriculture Organization of the United Nations (FAO)
- **Source link:** https://www.fao.org/faostat/en/#data/QCL
- **File name:** `FAOSTAT_data_en_11-18-2026.csv`
- **Collection date:** 18 November 2026
- **Geographical coverage:** East African countries
- **Licence:** FAOSTAT data is provided under the FAO's data-use terms. Confirm the applicable terms from the official source before redistribution.

## 2. What One Record Represents

One record represents an agricultural statistical observation for a particular country, crop or agricultural item, year, and indicator. Indicators may include production, area harvested, and yield.

## 3. Purpose of the Dataset

The dataset is used to analyze historical agricultural statistics, compare crop performance across countries and years, and support agricultural decision-making.

## 4. Data Quality Assessment

A detailed quality assessment will be conducted in Phase II. The following will be examined:

- Missing values
- Duplicate records
- Inconsistent country or crop names
- Invalid or inconsistent numerical values
- Data quality flags, including official, estimated, and imputed observations where provided

**Note:** Actual counts for each issue will be recorded after inspecting the raw CSV. No cleaning or modification has been performed on the original dataset.

## 5. Data Preservation

The original downloaded CSV is stored unchanged in:

`data/raw/FAOSTAT_data_en_11-18-2026.csv`

The raw dataset will be preserved as the source for subsequent normalization, logical design, and database implementation.
