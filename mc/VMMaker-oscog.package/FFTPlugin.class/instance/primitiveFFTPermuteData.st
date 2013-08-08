primitives
primitiveFFTPermuteData
	| rcvr |
	<export: true>
	rcvr := interpreterProxy stackObjectValue: 0.
	(self loadFFTFrom: rcvr) ifFalse:[^nil].
	self permuteData.
	interpreterProxy failed ifTrue:[
		"permuteData went wrong. Do the permutation again -- this will restore the original order"
		self permuteData].