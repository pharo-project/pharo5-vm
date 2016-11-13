I/O primitives
displayBitsOf: aForm Left: l Top: t Right: r Bottom: b
	"Repaint the portion of the Smalltalk screen bounded by the affected rectangle. Used to synchronize the screen after a Bitblt to the Smalltalk Display object."

	| displayObj dispBits w h dispBitsIndex d left right top bottom surfaceHandle |
	displayObj := objectMemory splObj: TheDisplay.
	aForm = displayObj ifFalse: [^ nil].
	self success: ((objectMemory isPointers: displayObj) and: [(objectMemory lengthOf: displayObj) >= 4]).
	self successful ifTrue: [
		dispBits := objectMemory fetchPointer: 0 ofObject: displayObj.
		w := self fetchInteger: 1 ofObject: displayObj.
		h := self fetchInteger: 2 ofObject: displayObj.
		d := self fetchInteger: 3 ofObject: displayObj.
	].
	l < 0 ifTrue:[left := 0] ifFalse: [left := l].
	r > w ifTrue: [right := w] ifFalse: [right := r].
	t < 0 ifTrue: [top := 0] ifFalse: [top := t].
	b > h ifTrue: [bottom := h] ifFalse: [bottom := b].
	((left <= right) and: [top <= bottom]) ifFalse: [^nil].
	self successful ifTrue: [
		(objectMemory isIntegerObject: dispBits) ifTrue: [
			surfaceHandle := objectMemory integerValueOf: dispBits.
			showSurfaceFn = 0 ifTrue: [
				showSurfaceFn := self ioLoadFunction: 'ioShowSurface' From: 'SurfacePlugin'.
				showSurfaceFn = 0 ifTrue: [^self success: false]].
			self cCode:'((int (*)(sqIntptr_t, int, int, int, int))showSurfaceFn)(surfaceHandle, left, top, right-left, bottom-top)'.
		] ifFalse: [
			self assert: (objectMemory isNonImmediate: dispBits).
			dispBitsIndex := dispBits + objectMemory baseHeaderSize.  "index in memory byte array"
			self cCode: 'ioShowDisplay(dispBitsIndex, w, h, d, left, right, top, bottom)'
				inSmalltalk: [self showDisplayBits: dispBitsIndex 
								w: w h: h d: d
								left: left right: right top: top bottom: bottom]
		].
	]