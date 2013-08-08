accessing
baseFP: pointer "<Integer>"
	"Set the value of baseFP"
	self assert: (pointer = 0 or: [pointer < baseAddress and: [realStackLimit < pointer]]).
	^baseFP := pointer