translation
isAccessor: aSelector
	"Answer if aSelector is simply an accessor method for one of our fields."
	^(self instVarIndexFor: (aSelector copyWithout: $:) ifAbsent: [0]) > 0