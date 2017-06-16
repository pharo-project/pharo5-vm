statistics
statAverageLivePagesWhenMapping: aFloat
	<var: #aFloat type: #double>
	aFloat == 0.0
		ifTrue: [statPageCountWhenMappingSum := statNumMaps := 0]
		ifFalse: [coInterpreter primitiveFailFor: PrimErrBadArgument]