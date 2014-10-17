debug printing
methodArg: index
	"Like #stackValue: but access method arguments left-to-right"
	index > argumentCount + 1 ifTrue:[
		self print: '[VM]: Attempt to access method args beyond range'.
		self printCallStack.
		self primitiveFail.
		^0].
	^self stackValue: argumentCount - index