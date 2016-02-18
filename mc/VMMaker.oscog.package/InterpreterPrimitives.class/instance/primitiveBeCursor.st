I/O primitives
primitiveBeCursor
	"Set the cursor to the given shape. The Mac only supports 16x16 pixel cursors. Cursor offsets are handled by Smalltalk."

	| cursorObj maskBitsIndex maskObj bitsObj extentX extentY depth offsetObj offsetX offsetY cursorBitsIndex ourCursor |

	argumentCount = 0 ifTrue: [
		cursorObj := self stackTop.
		maskBitsIndex := nil].
	argumentCount = 1 ifTrue: [
		cursorObj := self stackValue: 1.
		maskObj := self stackTop].
	self success: argumentCount < 2.

	self success: ((objectMemory isPointers: cursorObj) and: [(objectMemory lengthOf: cursorObj) >= 5]).
	self successful ifTrue: [
		bitsObj := objectMemory fetchPointer: 0 ofObject: cursorObj.
		extentX := self fetchInteger: 1 ofObject: cursorObj.
		extentY := self fetchInteger: 2 ofObject: cursorObj.
		depth := self fetchInteger: 3 ofObject: cursorObj.
		offsetObj := objectMemory fetchPointer: 4 ofObject: cursorObj].
		self success: ((objectMemory isPointers: offsetObj) and: [(objectMemory lengthOf: offsetObj) >= 2]).

	self successful ifTrue: [
		offsetX := self fetchInteger: 0 ofObject: offsetObj.
		offsetY := self fetchInteger: 1 ofObject: offsetObj.
		(argumentCount = 0 and: [depth = 32])
			ifTrue: [
				"Support arbitrary-sized 32 bit ARGB forms --bf 3/1/2007 23:51"
				self success: ((extentX > 0) and: [extentY > 0]).
				self success: ((offsetX >= (extentX * -1)) and: [offsetX <= 0]).
				self success: ((offsetY >= (extentY * -1)) and: [offsetY <= 0]).
				self success: ((objectMemory isWords: bitsObj) and: [(objectMemory lengthOf: bitsObj) = (extentX * extentY)]).
				cursorBitsIndex := bitsObj + objectMemory baseHeaderSize.
				self cCode: '' inSmalltalk:
					[ourCursor := Cursor
						extent: extentX @ extentY
						depth: 32
						fromArray: ((1 to: extentX * extentY) collect: [:i |
							objectMemory fetchLong32: i-1 ofObject: bitsObj])
						offset: offsetX  @ offsetY]]
			ifFalse: [
				self success: ((extentX = 16) and: [extentY = 16 and: [depth = 1]]).
				self success: ((offsetX >= -16) and: [offsetX <= 0]).
				self success: ((offsetY >= -16) and: [offsetY <= 0]).
				self success: ((objectMemory isWords: bitsObj) and: [(objectMemory lengthOf: bitsObj) = 16]).
				cursorBitsIndex := bitsObj + objectMemory baseHeaderSize.
				self cCode: '' inSmalltalk:
					[ourCursor := Cursor
						extent: extentX @ extentY
						fromArray: ((1 to: 16) collect: [:i |
							((objectMemory fetchLong32: i-1 ofObject: bitsObj) >> (objectMemory wordSize*8 - 16)) bitAnd: 16rFFFF])
						offset: offsetX  @ offsetY]]].

	argumentCount = 1 ifTrue: [
		self success: ((objectMemory isPointers: maskObj) and: [(objectMemory lengthOf: maskObj) >= 5]).
		self successful ifTrue: [
			bitsObj := objectMemory fetchPointer: 0 ofObject: maskObj.
			extentX := self fetchInteger: 1 ofObject: maskObj.
			extentY := self fetchInteger: 2 ofObject: maskObj.
			depth := self fetchInteger: 3 ofObject: maskObj].

		self successful ifTrue: [
			self success: ((extentX = 16) and: [extentY = 16 and: [depth = 1]]).
			self success: ((objectMemory isWords: bitsObj) and: [(objectMemory lengthOf: bitsObj) = 16]).
			maskBitsIndex := bitsObj + objectMemory baseHeaderSize]].

	self successful ifTrue: [
		argumentCount = 0
			ifTrue: [
				depth = 32
					ifTrue: [(self cCode: 'ioSetCursorARGB(cursorBitsIndex, extentX, extentY, offsetX, offsetY)'
						inSmalltalk: [ourCursor show. Cursor currentCursor == ourCursor])	
							ifFalse: [^self success: false]]
					ifFalse: [self cCode: 'ioSetCursor(cursorBitsIndex, offsetX, offsetY)'
						inSmalltalk: [ourCursor show]]]
			ifFalse: [self cCode: 'ioSetCursorWithMask(cursorBitsIndex, maskBitsIndex, offsetX, offsetY)'
						inSmalltalk: [cursorBitsIndex == maskBitsIndex. "placate compiler"
									ourCursor show]].
		self pop: argumentCount]