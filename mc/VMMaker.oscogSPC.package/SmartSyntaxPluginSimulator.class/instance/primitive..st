simulation
primitive: primNameString
	"If initializing, pass back the type signature.  If executing, answer nil."
	^self primitive: primNameString parameters: #() receiver: nil