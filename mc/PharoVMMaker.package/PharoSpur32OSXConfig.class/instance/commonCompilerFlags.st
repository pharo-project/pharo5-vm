settings
commonCompilerFlags
	^ super commonCompilerFlags, #('-DSPURVM' "'-DPHAROVM_USE_EXECUTABLE_MEMORY'")