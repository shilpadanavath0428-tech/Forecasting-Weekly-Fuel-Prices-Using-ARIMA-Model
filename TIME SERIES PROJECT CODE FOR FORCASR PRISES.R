library(readxl)
library(forecast)

# Load the dataset
file_path <- "C:/Users/123456/Documents/weekly fuel data @2.xlsx"  # Specify the file path
data <- read_excel(file_path, sheet = "Sheet1")

# Convert 'Date' column to Date format
data$Date <- as.Date(data$Date)

# Convert 'ULSP: Pump price (p/litre)' and 'ULSD: Pump price (p/litre)' to numeric
data$`ULSP:  Pump price (p/litre)` <- as.numeric(data$`ULSP:  Pump price (p/litre)`)
data$`ULSD: Pump price (p/litre)` <- as.numeric(data$`ULSD: Pump price (p/litre)`)

# Remove any rows with missing data
data <- na.omit(data)

# Create time series objects for ULSP (Petrol) and ULSD (Diesel) prices
ulsp_ts <- ts(data$`ULSP:  Pump price (p/litre)`, start = c(2003, 6), frequency = 52)  # Weekly frequency
ulsd_ts <- ts(data$`ULSD: Pump price (p/litre)`, start = c(2003, 6), frequency = 52)  # Weekly frequency

# Fit ARIMA models for both ULSP (Petrol) and ULSD (Diesel)
ulsp_fit <- auto.arima(ulsp_ts)
ulsd_fit <- auto.arima(ulsd_ts)

# Forecast the next year's prices (52 weeks) for both ULSP and ULSD
ulsp_forecast <- forecast(ulsp_fit, h = 52)
ulsd_forecast <- forecast(ulsd_fit, h = 52)

# Plot the forecasts for ULSP (Petrol) and ULSD (Diesel)
par(mfrow = c(2, 1))  # Set up the plot to display two graphs

# ULSP (Petrol) Forecast Plot
plot(ulsp_forecast, main = "Forecast of ULSP (Petrol) Prices for the Next Year",
     xlab = "Time", ylab = "ULSP (Petrol) Price (p/litre)")

# ULSD (Diesel) Forecast Plot
plot(ulsd_forecast, main = "Forecast of ULSD (Diesel) Prices for the Next Year",
     xlab = "Time", ylab = "ULSD (Diesel) Price (p/litre)")

# Print forecasted values for ULSP (Petrol)
print("ULSP (Petrol) Price Forecast:")
print(ulsp_forecast)

# Print forecasted values for ULSD (Diesel)
print("ULSD (Diesel) Price Forecast:")
print(ulsd_forecast)