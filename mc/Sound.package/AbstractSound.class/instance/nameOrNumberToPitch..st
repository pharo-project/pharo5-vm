initialization
nameOrNumberToPitch: aStringOrNumber
	"Answer the pitch in cycles/second for the given pitch specification. The specification can be either a numeric pitch or pitch name such as 'c4'."

	aStringOrNumber isNumber
		ifTrue: [^ aStringOrNumber asFloat]
		ifFalse: [^ AbstractSound pitchForName: aStringOrNumber]
