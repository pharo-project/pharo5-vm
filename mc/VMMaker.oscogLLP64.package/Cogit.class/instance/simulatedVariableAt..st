initialization
simulatedVariableAt: address
	"Answer a simulated variable's value for handling the push/pop tracer."
	<doNotGenerate>
	^(simulatedVariableGetters
		at: address
		ifAbsent:[0]) value