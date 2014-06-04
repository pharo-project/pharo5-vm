system primitives
primitiveShortDateFormat
	"return a string describing the long date formatting.
Format is made up of
d day, m month, y year,
double symbol is null padded, single not padded (m=6, mm=06)
dddd weekday
mmmm month name
"
	| oop length |
	self primitive:'primitiveShortDateFormat'.
	length := self sqLocShortDateFormatSize.
	oop := interpreterProxy instantiateClass: interpreterProxy classString indexableSize: length.
	self sqLocGetShortDateFormatInto: (interpreterProxy firstIndexableField: oop).
	^oop
