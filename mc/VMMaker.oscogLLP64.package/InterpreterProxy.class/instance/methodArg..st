stack access
methodArg: offset
	"Like #stackValue: but access method arguments left-to-right"
	offset > argumentCount + 1 ifTrue:[^self primitiveFail].
	^self stackValue: argumentCount - offset