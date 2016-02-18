compiler flags
commonCompilerFlags
	^ super commonCompilerFlags, #('-DSPURVM' '-DPharoVM')