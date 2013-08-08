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
	self success: (argumentCount < 2).

	self success: ((self isPointers: cursorObj) and: [(self lengthOf: cursorObj) >= 5]).
	self successful ifTrue: [
		bitsObj := self fetchPointer: 0 ofObject: cursorObj.
		extentX := self fetchInteger: 1 ofObject: cursorObj.
		extentY := self fetchInteger: 2 ofObject: cursorObj.
		depth := self fetchInteger: 3 ofObject: cursorObj.
		offsetObj := self fetchPointer: 4 ofObject: cursorObj].
		self success: ((self isPointers: offsetObj) and: [(self lengthOf: offsetObj) >= 2]).

	self successful ifTrue: [
		offsetX := self fetchInteger: 0 ofObject: offsetObj.
		offsetY := self fetchInteger: 1 ofObject: offsetObj.
		self success: ((extentX = 16) and: [extentY = 16 and: [depth = 1]]).
		self success: ((offsetX >= -16) and: [offsetX <= 0]).
		self success: ((offsetY >= -16) and: [offsetY <= 0]).
		self success: ((self isWords: bitsObj) and: [(self lengthOf: bitsObj) = 16]).
		cursorBitsIndex := bitsObj + BaseHeaderSize.
		self cCode: '' inSmalltalk:
			[ourCursor := Cursor
				extent: extentX @ extentY
				fromArray: ((1 to: 16) collect: [:i |
					((self fetchLong32: i-1 ofObject: bitsObj) >> (BytesPerWord*8 - 16)) bitAnd: 16rFFFF])
				offset: offsetX  @ offsetY]].

	argumentCount = 1 ifTrue: [
		self success: ((self isPointers: maskObj) and: [(self lengthOf: maskObj) >= 5]).
		self successful ifTrue: [
			bitsObj := self fetchPointer: 0 ofObject: maskObj.
			extentX := self fetchInteger: 1 ofObject: maskObj.
			extentY := self fetchInteger: 2 ofObject: maskObj.
			depth := self fetchInteger: 3 ofObject: maskObj].

		self successful ifTrue: [
			self success: ((extentX = 16) and: [extentY = 16 and: [depth = 1]]).
			self success: ((self isWords: bitsObj) and: [(self lengthOf: bitsObj) = 16]).
			maskBitsIndex := bitsObj + BaseHeaderSize]].

	self successful ifTrue: [
		argumentCount = 0
			ifTrue: [self cCode: 'ioSetCursor(cursorBitsIndex, offsetX, offsetY)'
						inSmalltalk: [ourCursor show]]
			ifFalse: [self cCode: 'ioSetCursorWithMask(cursorBitsIndex, maskBitsIndex, offsetX, offsetY)'
						inSmalltalk: [ourCursor show]].
		self pop: argumentCount].
