image save/restore
byteSwapped: w
	"Answer the given integer with its bytes in the reverse order."
	<api>
	<returnTypeC: #sqInt>
	^self cppIf: self wordSize = 4
		ifTrue: [w byteSwap32]
		ifFalse: [w byteSwap64]