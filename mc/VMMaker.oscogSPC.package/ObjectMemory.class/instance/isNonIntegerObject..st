interpreter access
isNonIntegerObject: objectPointer
	<api>
	^(objectPointer bitAnd: 1) = 0