loading state
loadColorTransformFrom: transformOop
	"Load a 2x3 transformation matrix from the given oop.
	Return true if the matrix is not nil, false otherwise"
	| okay transform |
	<var: #transform type:'float *'>
	transform := self colorTransform.
	self hasColorTransformPut: 0.
	okay := self loadTransformFrom: transformOop into: transform length: 8.
	okay ifFalse:[^false].
	self hasColorTransformPut: 1.
	"Scale transform to be in 0-256 range"
	transform at: 1 put: (transform at: 1) * (self cCoerce: 256.0 to:'float').
	transform at: 3 put: (transform at: 3) * (self cCoerce: 256.0 to:'float').
	transform at: 5 put: (transform at: 5) * (self cCoerce: 256.0 to:'float').
	transform at: 7 put: (transform at: 7) * (self cCoerce: 256.0 to:'float').
	^okay