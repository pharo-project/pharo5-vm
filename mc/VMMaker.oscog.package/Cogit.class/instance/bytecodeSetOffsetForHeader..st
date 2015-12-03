initialization
bytecodeSetOffsetForHeader: aMethodHeader
	<inline: true>
	^self
		cppIf: MULTIPLEBYTECODESETS
		ifTrue:
			[(coInterpreter headerIndicatesAlternateBytecodeSet: aMethodHeader)
				ifTrue: [256]
				ifFalse: [0]]
		ifFalse: [0]