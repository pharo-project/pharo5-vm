settings
commonCompilerFlags
	^ super commonCompilerFlags, #('-DSPURVM' '-DPharoVM')