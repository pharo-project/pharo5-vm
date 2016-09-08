system primitives
primitiveTimeFormat
	"return a string describing the time formatting.
Format is made up of
h hour (h 12, H 24), m minute, s seconds, x (am/pm String)
double symbol is null padded, single not padded (h=6, hh=06)"
	| oop length |
	self primitive:'primitiveTimeFormat'.
	length := self sqLocTimeFormatSize.
	oop := interpreterProxy instantiateClass: interpreterProxy classString indexableSize: length.
	self sqLocGetTimeFormatInto: (interpreterProxy firstIndexableField: oop).
	^oop
