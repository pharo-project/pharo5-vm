accessing
headFP: pointer "<Integer>"
	"Set the value of headFP"
	"N.B.  This assert is run in simulation only because headFP:
	 becomes a simple field assignment in the C code."
	self assert: (pointer = 0 or: [pointer < baseAddress and: [realStackLimit - (LargeContextSize / 2) <= pointer]]).
	^headFP := pointer