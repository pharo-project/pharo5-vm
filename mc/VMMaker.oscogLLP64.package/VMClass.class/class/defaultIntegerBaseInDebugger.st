debugger
defaultIntegerBaseInDebugger
	"DefaultBase := 16."
	"DefaultBase := 10."
	DefaultBase isNil ifTrue: [DefaultBase := 16].
	^DefaultBase