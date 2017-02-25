primitives
primitiveComposeMatrix
	| m1 m2 m3 result |
	<export: true>
	<inline: false>
	<var: #m1 type: #'float *'>
	<var: #m2 type: #'float *'>
	<var: #m3 type: #'float *'>
	self cCode: ''  "Make this fail in simulation"
		inSmalltalk: [interpreterProxy success: false. ^ nil].
	m3 := self loadArgumentMatrix: (result := interpreterProxy stackObjectValue: 0).
	m2 := self loadArgumentMatrix: (interpreterProxy stackObjectValue: 1).
	m1 := self loadArgumentMatrix: (interpreterProxy stackObjectValue: 2).
	interpreterProxy failed ifTrue:[^nil].
	self matrix2x3ComposeMatrix: m1 with: m2 into: m3.
	interpreterProxy pop: 3 thenPush: result