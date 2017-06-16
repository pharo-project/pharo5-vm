statistics
statAverageLivePagesWhenMapping
	<returnTypeC: #double>
	^statNumMaps = 0
		ifTrue: [0.0]
		ifFalse: [statPageCountWhenMappingSum asFloat / statNumMaps]