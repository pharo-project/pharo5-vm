C core util
cDigitReplace: pTo from: start to: stop with: pFrom startingAt: repStart 
	"C indexed!"
	<var: #pTo type: #'unsigned int *'>
	<var: #pFrom type: #'unsigned int *'>
	^ self
		cDigitCopyFrom: pFrom + repStart
		to: pTo + start
		len: stop - start + 1