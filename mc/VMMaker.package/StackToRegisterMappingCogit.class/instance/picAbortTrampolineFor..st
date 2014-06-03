trampolines
picAbortTrampolineFor: numArgs
	^picAbortTrampolines at: (numArgs min: self numRegArgs + 1)