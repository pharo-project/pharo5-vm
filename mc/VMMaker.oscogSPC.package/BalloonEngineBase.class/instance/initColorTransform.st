other
initColorTransform
	| transform |
	<inline: false>
	<var: #transform type:'float *'>
	transform := self colorTransform.
	transform at: 0 put: (self cCoerce: 1.0 to: 'float').
	transform at: 1 put: (self cCoerce: 0.0 to: 'float').
	transform at: 2 put: (self cCoerce: 1.0 to: 'float').
	transform at: 3 put: (self cCoerce: 0.0 to: 'float').
	transform at: 4 put: (self cCoerce: 1.0 to: 'float').
	transform at: 5 put: (self cCoerce: 0.0 to: 'float').
	transform at: 6 put: (self cCoerce: 1.0 to: 'float').
	transform at: 7 put: (self cCoerce: 0.0 to: 'float').
	self hasColorTransformPut: 0.