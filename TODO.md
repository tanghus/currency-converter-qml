## Currency Converter TODO:
## Installed
  * List of countries as JSON

## On first load:
  * Load and parse list of available countries
    * Save as LocalStorage in user space.
  * Load and parse list of available currencies
    * Save as LocalStorage in user space.

### Requirements:
  * Methods to:
    * Look up currency name based on currency code (and save to db if needed?)
    * Look up rate from said currency - implemented
    * Look up country code from currency code. For flags

## Different providers:
  * Separate Storage for providers
  * Interpolate query parameters into URL
  * Setting for refresh rates
  * API key

Table "countries"

Table "providers"
  * int: id
  * string: displayName
  * string: URL including variables
  * bool: Needs API
  * string: API key
  * int: Update/refresh rate

Table "rates"
