class initialization
initializeMiscConstants
	super initializeMiscConstants.
	MaxLiteralCountForCompile := initializationOptions at: #MaxLiteralCountForCompile ifAbsent: [60].
	NumTrampolines := 42
						+ (NewspeakVM ifTrue: [18] ifFalse: [0])
						+ (BytecodeSetHasDirectedSuperSend ifTrue: [4] ifFalse: [0])