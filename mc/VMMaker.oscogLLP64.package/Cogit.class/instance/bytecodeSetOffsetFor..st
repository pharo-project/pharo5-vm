initialization
bytecodeSetOffsetFor: aMethodObj
	<inline: true>
	^self
		cppIf: MULTIPLEBYTECODESETS
		ifTrue:
			[(coInterpreter methodUsesAlternateBytecodeSet: aMethodObj)
				ifTrue: [256]
				ifFalse: [0]]
		ifFalse: [0]