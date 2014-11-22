I/O primitives
primitiveFormPrint
	"On platforms that support it, this primitive prints the receiver, assumed to be a Form, to the default printer."

	| landscapeFlag vScale hScale rcvr bitsArray w h
	 depth pixelsPerWord wordsPerLine bitsArraySize ok |

	<var: #vScale type: #double>
	<var: #hScale type: #double>
	landscapeFlag := self booleanValueOf: self stackTop.
	vScale := objectMemory floatValueOf: (self stackValue: 1).
	hScale := objectMemory floatValueOf: (self stackValue: 2).
	rcvr := self stackValue: 3.
	((objectMemory isPointers: rcvr)
	 and: [(objectMemory lengthOf: rcvr) >= 4]) ifFalse:
		[self success: false].
	self successful ifTrue:
		[bitsArray := objectMemory fetchPointer: 0 ofObject: rcvr.
		w := self fetchInteger: 1 ofObject: rcvr.
		h := self fetchInteger: 2 ofObject: rcvr.
		depth := self fetchInteger: 3 ofObject: rcvr.
		(w > 0 and: [h > 0]) ifFalse: [self success: false].
		pixelsPerWord := 32 // depth.
		wordsPerLine := (w + (pixelsPerWord - 1)) // pixelsPerWord.
		(objectMemory isWordsOrBytes: bitsArray)
			ifTrue:
				[bitsArraySize := objectMemory numBytesOf: bitsArray.
				self success: (bitsArraySize = (wordsPerLine * h * 4))]
			ifFalse: [self success: false]].	
	self successful ifTrue:
		[ok := self cCode: 'ioFormPrint(bitsArray + BaseHeaderSize, w, h, depth, hScale, vScale, landscapeFlag)'.
		self success: ok].
	self successful ifTrue:
		[self pop: 3]	"pop hScale, vScale, and landscapeFlag; leave rcvr on stack"