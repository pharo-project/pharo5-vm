method map
blockCreationBytecodeSizeForHeader: methodHeader
	<inline: true>
	^self cppIf: MULTIPLEBYTECODESETS
		ifTrue:
			[(coInterpreter headerIndicatesAlternateBytecodeSet: methodHeader)
				ifTrue: [AltBlockCreationBytecodeSize]
				ifFalse: [BlockCreationBytecodeSize]]
		ifFalse: [BlockCreationBytecodeSize]