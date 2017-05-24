I/O primitive support
reverseDisplayFrom: startIndex to: endIndex 
	"Reverse the given range of Display pixels, rounded to whole word boundary.
	Used to give feedback during VM activities such as garbage collection when debugging.
	 It is assumed that the given word range falls entirely within the first line of the Display."
	
	| wordStartIndex wordEndIndex primFailCodeValue |
	(displayBits = 0 or: [(objectMemory isImmediate: displayBits asInteger) or: [displayDepth = 0]]) ifTrue: [^nil].
	wordStartIndex := (startIndex max: 0) * displayDepth // 32.
	wordEndIndex := (endIndex min: displayWidth) * displayDepth // 32.
	wordStartIndex * 4 to: wordEndIndex * 4 do:
		[:byteOffset | | reversed |
		reversed := (objectMemory long32At: displayBits asInteger + byteOffset) bitXor: 16rFFFFFFFF.
		objectMemory long32At: displayBits asInteger + byteOffset put: reversed].
	primFailCodeValue := primFailCode.
	self initPrimCall.
	self updateDisplayLeft: 0 Top: 0 Right: displayWidth Bottom: 1.
	self ioForceDisplayUpdate.
	primFailCode := primFailCodeValue