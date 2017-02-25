transforms
primitiveTransformMatrixWithInto
	"Transform two matrices into the third"
	| m1 m2 m3 |
	<export: true>
	<inline: false>
	<var: #m1 declareC:'float *m1'>
	<var: #m2 declareC:'float *m2'>
	<var: #m3 declareC:'float *m3'>

	m3 := self stackMatrix: 0.
	m2 := self stackMatrix: 1.
	m1 := self stackMatrix: 2.
	(m1 = nil) | (m2 = nil) | (m3 = nil) 
		ifTrue:[^interpreterProxy primitiveFail].
	m2 == m3 ifTrue:[^interpreterProxy primitiveFail].
	self transformMatrix: m1 with: m2 into: m3.
	^interpreterProxy pop: 3. "Leave rcvr on stack"