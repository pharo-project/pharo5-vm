class initialization
initializeMiscConstants
	super initializeMiscConstants.
	NumTrampolines := NewspeakVM
							ifTrue: [63]
							ifFalse: [52]