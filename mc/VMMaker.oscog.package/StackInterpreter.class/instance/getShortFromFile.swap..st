image save/restore
getShortFromFile: aFile swap: swapFlag
	"Answer the next half-word read from aFile, byte-swapped according to the swapFlag."

	| w |
	<var: #aFile type: #'sqImageFile'>
	w := 0.
	self cCode: 'sqImageFileRead(&w, sizeof(unsigned short), 1, aFile)'.
	^swapFlag
		ifTrue: [(w bitShift: -8) + ((w bitAnd: 16rFF) bitShift: 8)]
		ifFalse: [w]