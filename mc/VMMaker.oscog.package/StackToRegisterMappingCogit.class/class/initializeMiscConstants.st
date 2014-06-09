class initialization
initializeMiscConstants
	super initializeMiscConstants.
	NumTrampolines := NewspeakVM
							ifTrue: [60]
							ifFalse: [52]