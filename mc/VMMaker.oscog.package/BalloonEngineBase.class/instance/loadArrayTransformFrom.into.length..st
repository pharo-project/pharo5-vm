loading state
loadArrayTransformFrom: transformOop into: destPtr length: n
	"Load a transformation from the given array."
	| value |
	<inline: false>
	<var: #destPtr type:'float *'>
	0 to: n-1 do:[:i|
		value := interpreterProxy fetchPointer: i ofObject: transformOop.
		((interpreterProxy isIntegerObject: value) or:[interpreterProxy isFloatObject: value])
			ifFalse:[^interpreterProxy primitiveFail].
		(interpreterProxy isIntegerObject: value)
			ifTrue:[destPtr at: i put: 
				(self cCoerce: (interpreterProxy integerValueOf: value) asFloat to:'float')]
			ifFalse:[destPtr at: i put: 
				(self cCoerce: (interpreterProxy floatValueOf: value) to: 'float')].
	].