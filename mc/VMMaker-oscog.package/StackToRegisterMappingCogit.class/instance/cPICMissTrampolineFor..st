trampolines
cPICMissTrampolineFor: numArgs
	^picMissTrampolines at: (numArgs min: self numRegArgs + 1)