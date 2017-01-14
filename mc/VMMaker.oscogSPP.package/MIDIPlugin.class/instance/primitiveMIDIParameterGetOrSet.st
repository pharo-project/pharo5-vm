primitives
primitiveMIDIParameterGetOrSet
	"Backward compatibility"
	<export: true>
	interpreterProxy methodArgumentCount = 1
		ifTrue:[^self primitiveMIDIParameterGet]
		ifFalse:[^self primitiveMIDIParameterSet]