primitives
primitiveTransformPoint
	| matrix |
	<export: true>
	<inline: false>
	<var: #matrix type: 'float *'>
	self loadArgumentPoint: (interpreterProxy stackObjectValue: 0).
	matrix := self loadArgumentMatrix: (interpreterProxy stackObjectValue: 1).
	interpreterProxy failed ifTrue:[^nil].
	self matrix2x3TransformPoint: matrix.
	self roundAndStoreResultPoint: 2.