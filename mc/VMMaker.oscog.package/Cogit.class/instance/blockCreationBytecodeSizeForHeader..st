method map
blockCreationBytecodeSizeForHeader: aMethodHeader
	<inline: true>
	^self cppIf: MULTIPLEBYTECODESETS
		ifTrue:
			[(objectMemory headerIndicatesAlternateBytecodeSet: aMethodHeader)
				ifTrue: [AltBlockCreationBytecodeSize]
				ifFalse: [BlockCreationBytecodeSize]]
		ifFalse: [BlockCreationBytecodeSize]