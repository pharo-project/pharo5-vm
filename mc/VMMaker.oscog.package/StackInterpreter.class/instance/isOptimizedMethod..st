compiled methods
isOptimizedMethod: header
	<api>
	^ (header >> MethodHeaderOptimizedBitShift bitAnd: 1) = 1 