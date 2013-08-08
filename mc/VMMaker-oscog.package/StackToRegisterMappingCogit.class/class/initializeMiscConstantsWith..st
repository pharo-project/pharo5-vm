class initialization
initializeMiscConstantsWith: optionsDictionary
	super initializeMiscConstantsWith: optionsDictionary.
	NumTrampolines := NewspeakVM
							ifTrue: [58]
							ifFalse: [50]