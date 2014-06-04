interpreter access
isOopCompiledMethod: oop
	"Answer whether the oop is an object of compiled method format"
	<api>
	^(self isNonIntegerObject: oop)
	 and: [(self formatOf: oop) >= self firstCompiledMethodFormat]