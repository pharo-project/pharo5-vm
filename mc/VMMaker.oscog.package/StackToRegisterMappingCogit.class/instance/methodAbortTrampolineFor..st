trampolines
methodAbortTrampolineFor: numArgs
	^methodAbortTrampolines at: (numArgs min: self numRegArgs + 1)