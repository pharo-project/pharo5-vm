method map
blockCreationBytecodeSizeForHeader: aMethodHeader
	<inline: true>
	^self cppIf: MULTIPLEBYTECODESETS
		ifTrue:
			[(coInterpreter headerIndicatesAlternateBytecodeSet: aMethodHeader)
				ifTrue: [AltBlockCreationBytecodeSize]
				ifFalse: [BlockCreationBytecodeSize]]
		ifFalse: [BlockCreationBytecodeSize]