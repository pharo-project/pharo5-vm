memory access
floatAt: index
	| value |
	value := self at: index.
	value isFloat ifFalse:
		[value = 0 ifTrue: [^ 0.0].
		self error: 'non-float was stored'.
		^ Float fromIEEE32Bit: value].
	^ value