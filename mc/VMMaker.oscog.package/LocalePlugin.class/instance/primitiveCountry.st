system primitives
primitiveCountry
	"return a 3 char string describing the country in use. ISO 3166 is the relevant source here; see http://www.unicode.org/onlinedat/countries.html for details. Using the 3 character Alpha-3 codes"
	| oop |
	self primitive:'primitiveCountry'.
	oop := interpreterProxy instantiateClass: interpreterProxy classString indexableSize: 3.
	self sqLocGetCountryInto: (interpreterProxy firstIndexableField: oop).
	^oop
