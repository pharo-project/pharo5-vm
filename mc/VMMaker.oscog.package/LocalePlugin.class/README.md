LocalePlugin provides access to some localization info.
primLanguage - returns a string describing the language in use as per ISO 639
primCountry - returns a string with country tag as per ISO 639
primVMOffsetToUTC - returns offset from UTC to time as provided by the VM. integer of minutes to allow for those odd places with halkf-hour offeset.
primTimeZone - returns UTC offset (? why two?)
primDST - returns boolean to indicate DST in use
primDecimalSymbol - return string with '.' or ',' etc
primDigitGrouping - return string with ',' or '.' etc for thousands type separation
primTimeFormat - return string with time dispaly format string - eg 'hh:mm:ss' etc
primLongDateFOrmat - return string with long date formatting - eg 'dd/mm/yyyy'
primShortDateFOrmat - similar but shortform
primCurrencySymbol - return string of currency name
primCurrencyNotation - return boolean for pre or postfix currency symbol
primMeasurement - return boolean for imperial or metric

