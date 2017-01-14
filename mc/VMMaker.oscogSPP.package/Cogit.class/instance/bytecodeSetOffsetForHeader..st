initialization
bytecodeSetOffsetForHeader: aMethodHeader
	<inline: true>
	^self
		cppIf: MULTIPLEBYTECODESETS
		ifTrue:
			[(objectMemory headerIndicatesAlternateBytecodeSet: aMethodHeader)
				ifTrue: [256]
				ifFalse: [0]]
		ifFalse: [0]