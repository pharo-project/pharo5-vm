loading state
loadEdgeTransformFrom: transformOop
	"Load a 2x3 transformation matrix from the given oop.
	Return true if the matrix is not nil, false otherwise"
	| transform okay |
	<inline: false>
	<var: #transform type:'float *'>
	self hasEdgeTransformPut: 0.
	transform := self edgeTransform.
	okay := self loadTransformFrom: transformOop into: transform length: 6.
	interpreterProxy failed ifTrue:[^nil].
	okay ifFalse:[^false].
	self hasEdgeTransformPut: 1.
	"Add the fill offset to the matrix"
	transform at: 2 put: 
		(self cCoerce: (transform at: 2) + self destOffsetXGet asFloat to:'float').
	transform at: 5 put: 
		(self cCoerce: (transform at: 5) + self destOffsetYGet asFloat to:'float').
	^true