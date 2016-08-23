I/O primitive support
reverseDisplayFrom: startIndex to: endIndex 
	"Reverse the given range of Display words (at different bit 
	depths, this will reverse different numbers of pixels). Used to 
	give feedback during VM activities such as garbage 
	collection when debugging. It is assumed that the given 
	word range falls entirely within the first line of the Display."
	| displayObj displayBits w wordStartIndex wordEndIndex primFailCodeValue |
	displayObj := objectMemory splObj: TheDisplay.
	((objectMemory isPointers: displayObj) and: [(objectMemory lengthOf: displayObj) >= 4]) ifFalse: [^ nil].
	w := objectMemory fetchPointer: 1 ofObject: displayObj.
	displayBits := objectMemory fetchPointer: 0 ofObject: displayObj.
	((objectMemory isImmediate: displayBits)
	or: [(objectMemory isNonIntegerObject: w)
	or: [objectMemory isPointersNonImm: displayBits]]) ifTrue: [^ nil].
	wordStartIndex := startIndex * 4.
	wordEndIndex := endIndex * 4 min: (objectMemory sizeBitsOf: displayBits).
	displayBits := displayBits + objectMemory baseHeaderSize.
	displayBits + wordStartIndex to: displayBits + wordEndIndex by: 4 do:
		[:ptr | | reversed  |
		reversed := (objectMemory long32At: ptr) bitXor: 16rFFFFFFFF.
		objectMemory long32At: ptr put: reversed].
	primFailCodeValue := primFailCode.
	self initPrimCall.
	self displayBitsOf: displayObj Left: 0 Top: 0 Right: (objectMemory integerValueOf: w) Bottom: 1.
	self ioForceDisplayUpdate.
	primFailCode := primFailCodeValue