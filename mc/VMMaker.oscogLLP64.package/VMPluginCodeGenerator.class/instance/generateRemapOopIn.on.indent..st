C translation
generateRemapOopIn: aNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream cr; nextPutAll: '#if SPURVM'; cr.
	self generateSpurRemapOopIn: aNode on: aStream indent: level.
	aStream cr; nextPutAll: '#else /* SPURVM */'; cr.
	self generateV3RemapOopIn: aNode on: aStream indent: level.
	aStream cr; nextPutAll: '#endif /* SPURVM */'; cr