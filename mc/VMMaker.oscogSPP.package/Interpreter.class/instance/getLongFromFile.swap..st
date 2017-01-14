image save/restore
getLongFromFile: aFile swap: swapFlag
	"Answer the next word read from aFile, byte-swapped according to the swapFlag."

	| w |
	<var: #aFile type: 'sqImageFile '>
	w := 0.
	self cCode: 'sqImageFileRead(&w, sizeof(w), 1, aFile)'.
	swapFlag
		ifTrue: [^ self byteSwapped: w]
		ifFalse: [^ w].
