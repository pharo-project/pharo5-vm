transforming
transformData: forward
	self permuteData.
	interpreterProxy failed ifTrue:[
		"permuteData went wrong. Do the permutation again -- this will restore the original order"
		self permuteData.
		^nil].
	self transformForward: forward.
	forward ifFalse: [self scaleData]  "Reverse transform must scale to be an inverse"