plugin primitive support
methodArg: index
	"Like #stackValue: but access method arguments left-to-right"
	index > argumentCount + 1 ifTrue:[
		self cCode: 'fprintf(stderr,"[VM]: Attempt to access method args beyond range\n")'.
		self printCallStack.
		self primitiveFail.
		^0].
	^self stackValue: argumentCount - index