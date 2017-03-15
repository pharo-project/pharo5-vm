interpreter interface
showDisplayBits
	self ensureDestAndSourceFormsAreValid.
	interpreterProxy 
		showDisplayBits: destForm
		Left: affectedL
		Top: affectedT
		Right: affectedR
		Bottom: affectedB