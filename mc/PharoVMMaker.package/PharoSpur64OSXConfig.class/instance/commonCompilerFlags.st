settings
commonCompilerFlags
	^ super commonCompilerFlags, #(
		'-DUSE_CORE_GRAPHICS' 
		'-DSPURVM' 
		'-DPharoVM' 
		"'-DPHAROVM_USE_EXECUTABLE_MEMORY'")