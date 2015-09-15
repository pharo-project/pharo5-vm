compiler flags
commonCompilerFlags
	^ super commonCompilerFlags, #('-DSPURVM' '-DPharoVM' "'-DPHAROVM_USE_EXECUTABLE_MEMORY'")