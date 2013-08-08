primitives
primitiveCopyBits
	"Invoke the copyBits primitive. If the destination is the display, then copy it to the screen."
	| rcvr |
	<export: true>
	rcvr := interpreterProxy stackValue: interpreterProxy methodArgumentCount.
	(self loadBitBltFrom: rcvr)  ifFalse:[^interpreterProxy primitiveFail].
	self copyBits.
	interpreterProxy failed ifTrue:[^nil].
	self showDisplayBits.
	interpreterProxy failed ifTrue:[^nil].
	interpreterProxy pop: interpreterProxy methodArgumentCount.
	(combinationRule = 22) | (combinationRule = 32) ifTrue:[
		interpreterProxy pop: 1.
		^ interpreterProxy pushInteger: bitCount].