initialization
bytecodeSetOffsetForHeader: methodHeader
	<inline: true>
	^self
		cppIf: MULTIPLEBYTECODESETS
		ifTrue:
			[(coInterpreter headerIndicatesAlternateBytecodeSet: methodHeader)
				ifTrue: [256]
				ifFalse: [0]]
		ifFalse: [0]