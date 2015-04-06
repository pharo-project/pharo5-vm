class initialization
initializeMiscConstants
	super initializeMiscConstants.
	NumTrampolines := NewspeakVM
							ifTrue: [70]
							ifFalse: [52]