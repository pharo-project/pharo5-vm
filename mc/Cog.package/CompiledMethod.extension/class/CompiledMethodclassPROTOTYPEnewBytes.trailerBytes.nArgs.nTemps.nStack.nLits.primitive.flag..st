*Cog-method prototypes
CompiledMethodclassPROTOTYPEnewBytes: numberOfBytes trailerBytes: trailer nArgs: nArgs nTemps: nTemps nStack: stackSize nLits: nLits primitive: primitiveIndex flag: flag
	"Answer an instance of me. The header is specified by the message 
	 arguments. The remaining parts are not as yet determined."
	nTemps > 63 ifTrue:
		[^self error: 'Cannot compile -- too many temporary variables'].	
	nLits > 65535 ifTrue:
		[^self error: 'Cannot compile -- too many literals'].

	^trailer
		createMethod: numberOfBytes
		class: self
		header:    (nArgs bitShift: 24)
				+ (nTemps bitShift: 18)
				+ ((nTemps + stackSize) > SmallFrame ifTrue: [1 bitShift: 17] ifFalse: [0])
				+ nLits
				+ (primitiveIndex > 0 ifTrue: [1 bitShift: 16] ifFalse: [0])
				+ (flag ifTrue: [1 bitShift: 29] ifFalse: [0])