class initialization
initializeMiscConstants
	super initializeMiscConstants.
	NumTrampolines := NewspeakVM
							ifTrue: [67]
							ifFalse: [53]