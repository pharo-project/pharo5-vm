class initialization
initializeMiscConstants
	super initializeMiscConstants.
	MaxLiteralCountForCompile := initializationOptions at: #MaxLiteralCountForCompile ifAbsent: [60].
	NumTrampolines := NewspeakVM
							ifTrue: [46]
							ifFalse: [38]