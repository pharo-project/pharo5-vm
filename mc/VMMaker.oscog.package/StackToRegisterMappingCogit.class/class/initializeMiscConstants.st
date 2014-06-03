class initialization
initializeMiscConstants
	super initializeMiscConstants.
	NumTrampolines := NewspeakVM
							ifTrue: [58]
							ifFalse: [50]