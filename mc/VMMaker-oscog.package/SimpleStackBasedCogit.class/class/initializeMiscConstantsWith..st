class initialization
initializeMiscConstantsWith: optionsDictionary
	super initializeMiscConstantsWith: optionsDictionary.
	MaxLiteralCountForCompile := optionsDictionary at: #MaxLiteralCountForCompile ifAbsent: [60].
	NumTrampolines := NewspeakVM
							ifTrue: [46]
							ifFalse: [38]