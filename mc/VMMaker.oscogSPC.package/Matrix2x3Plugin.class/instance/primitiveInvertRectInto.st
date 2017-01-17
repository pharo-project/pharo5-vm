primitives
primitiveInvertRectInto
	| matrix srcOop dstOop originX originY cornerX cornerY minX maxX minY maxY |
	<export: true>
	<inline: false>
	<var: #matrix type: 'float *'>
	<var: #originX type: 'double '>
	<var: #originY type: 'double '>
	<var: #cornerX type: 'double '>
	<var: #cornerY type: 'double '>
	<var: #minX type: 'double '>
	<var: #maxX type: 'double '>
	<var: #minY type: 'double '>
	<var: #maxY type: 'double '>

	dstOop := interpreterProxy stackObjectValue: 0.
	srcOop := interpreterProxy stackObjectValue: 1.
	matrix := self loadArgumentMatrix: (interpreterProxy stackObjectValue: 2).
	interpreterProxy failed ifTrue:[^nil].

	(interpreterProxy fetchClassOf: srcOop) = (interpreterProxy fetchClassOf: dstOop)
		ifFalse:[^interpreterProxy primitiveFail].
	(interpreterProxy isPointers: srcOop)
		ifFalse:[^interpreterProxy primitiveFail].
	(interpreterProxy slotSizeOf: srcOop) = 2
		ifFalse:[^interpreterProxy primitiveFail].

	"Load top-left point"
	self loadArgumentPoint: (interpreterProxy fetchPointer: 0 ofObject: srcOop).
	interpreterProxy failed ifTrue:[^nil].
	originX := m23ArgX.
	originY := m23ArgY.
	self matrix2x3InvertPoint: matrix.
	minX := maxX := m23ResultX.
	minY := maxY := m23ResultY.

	"Load bottom-right point"
	self loadArgumentPoint:(interpreterProxy fetchPointer: 1 ofObject: srcOop).
	interpreterProxy failed ifTrue:[^nil].
	cornerX := m23ArgX.
	cornerY := m23ArgY.
	self matrix2x3InvertPoint: matrix.
	minX := minX min: m23ResultX.
	maxX := maxX max: m23ResultX.
	minY := minY min: m23ResultY.
	maxY := maxY max: m23ResultY.

	"Load top-right point"
	m23ArgX := cornerX.
	m23ArgY := originY.
	self matrix2x3InvertPoint: matrix.
	minX := minX min: m23ResultX.
	maxX := maxX max: m23ResultX.
	minY := minY min: m23ResultY.
	maxY := maxY max: m23ResultY.

	"Load bottom-left point"
	m23ArgX := originX.
	m23ArgY := cornerY.
	self matrix2x3InvertPoint: matrix.
	minX := minX min: m23ResultX.
	maxX := maxX max: m23ResultX.
	minY := minY min: m23ResultY.
	maxY := maxY max: m23ResultY.

	interpreterProxy failed ifFalse:[
		dstOop := self roundAndStoreResultRect: dstOop x0: minX y0: minY x1: maxX y1: maxY].
	interpreterProxy failed ifFalse:[
		interpreterProxy pop: 3 thenPush: dstOop
	]
