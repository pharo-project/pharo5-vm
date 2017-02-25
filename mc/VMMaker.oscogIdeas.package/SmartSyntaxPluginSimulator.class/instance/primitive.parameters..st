simulation
primitive: primNameString parameters: argumentClassNames
	"If initializing, pass back the type signature.  If executing, answer nil."
	^self primitive: primNameString parameters: argumentClassNames receiver: nil