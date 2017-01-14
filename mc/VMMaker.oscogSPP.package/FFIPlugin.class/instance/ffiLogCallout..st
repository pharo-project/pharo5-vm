symbol loading
ffiLogCallout: lit
	"fetch the function name"
	| functionName |
	ffiLogEnabled ifTrue:[
		functionName := interpreterProxy fetchPointer: externalFunctionInstSize ofObject: lit.
		(interpreterProxy isBytes: functionName) ifFalse:[^nil].
		self ffiLogCall: (interpreterProxy firstIndexableField: functionName)
			OfLength: (interpreterProxy byteSizeOf: functionName).
	].