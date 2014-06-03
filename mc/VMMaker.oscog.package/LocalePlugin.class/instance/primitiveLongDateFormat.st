system primitives
primitiveLongDateFormat
	"return a string describing the long date formatting.
Format is made up of
d day, m month, y year,
double symbol is null padded, single not padded (m=6, mm=06)
dddd weekday
mmmm month name
"
	| oop length |
	self primitive:'primitiveLongDateFormat'.
	length := self sqLocLongDateFormatSize.
	oop := interpreterProxy instantiateClass: interpreterProxy classString indexableSize: length.
	self sqLocGetLongDateFormatInto: (interpreterProxy firstIndexableField: oop).
	^oop
