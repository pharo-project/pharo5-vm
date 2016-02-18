image save/restore
imageFormatCompatibilityVersion
	"This VM is backward-compatible with the immediately preceding version."

	^objectMemory wordSize == 4 ifTrue: [6504] ifFalse: [68002]