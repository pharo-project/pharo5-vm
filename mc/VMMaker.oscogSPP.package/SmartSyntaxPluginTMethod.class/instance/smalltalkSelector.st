accessing
smalltalkSelector
	"Answer the selector of the original Smalltalk method, not any mangled one."
	^fullSelector ifNil: [selector]