C core util
cBytesReplace: pTo from: start to: stop with: pFrom startingAt: repStart 
	"C indexed!"
	<returnTypeC: 'int'>
	<var: #pTo type: 'unsigned char * '>
	<var: #pFrom type: 'unsigned char * '>
	^ self
		cBytesCopyFrom: pFrom + repStart
		to: pTo + start
		len: stop - start + 1