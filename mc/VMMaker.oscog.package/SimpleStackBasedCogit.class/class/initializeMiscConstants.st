class initialization
initializeMiscConstants
	super initializeMiscConstants.
	MaxLiteralCountForCompile := initializationOptions at: #MaxLiteralCountForCompile ifAbsent: [60].
	NumTrampolines := NewspeakVM
							ifTrue: [50]
							ifFalse: [42]