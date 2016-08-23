private
roundAndStoreResultRect: dstOop x0: x0 y0: y0 x1: x1 y1: y1
	"Check, round and store the result of a rectangle operation"
	| minX maxX minY maxY originOop cornerOop rectOop |
	<var: #x0 type: 'double '>
	<var: #y0 type: 'double '>
	<var: #x1 type: 'double '>
	<var: #y1 type: 'double '>
	<var: #minX type: 'double '>
	<var: #maxX type: 'double '>
	<var: #minY type: 'double '>
	<var: #maxY type: 'double '>

	minX := x0 + 0.5.
	(self okayIntValue: minX) ifFalse:[^interpreterProxy primitiveFail].
	maxX := x1 + 0.5.
	(self okayIntValue: maxX) ifFalse:[^interpreterProxy primitiveFail].
	minY := y0 + 0.5.
	(self okayIntValue: minY) ifFalse:[^interpreterProxy primitiveFail].
	maxY := y1 + 0.5.
	(self okayIntValue: maxY) ifFalse:[^interpreterProxy primitiveFail].

	interpreterProxy pushRemappableOop: dstOop.
	originOop := interpreterProxy makePointwithxValue: minX asInteger yValue: minY asInteger.
	interpreterProxy pushRemappableOop: originOop.
	cornerOop := interpreterProxy makePointwithxValue: maxX asInteger yValue: maxY asInteger.
	originOop := interpreterProxy popRemappableOop.
	rectOop := interpreterProxy popRemappableOop.
	interpreterProxy storePointer: 0 ofObject: rectOop withValue: originOop.
	interpreterProxy storePointer: 1 ofObject: rectOop withValue: cornerOop.
	^rectOop