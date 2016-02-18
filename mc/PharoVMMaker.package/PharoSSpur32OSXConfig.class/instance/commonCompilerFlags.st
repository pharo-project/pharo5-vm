settings
commonCompilerFlags
	^ super commonCompilerFlags, #(
		'-DUSE_CORE_GRAPHICS' 
		'-DSPURVM' 
		'-DPharoVM')