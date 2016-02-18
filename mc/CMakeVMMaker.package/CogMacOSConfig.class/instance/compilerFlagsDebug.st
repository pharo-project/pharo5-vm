compiler flags
compilerFlagsDebug

	^ {
		'-g3'. 
		'-O0'. 
		'-Wmissing-prototypes'. 
		'-Wmissing-braces'. 
		'-Wparentheses'. 
		'-Wunused-function'. 
		'-Wunused-label'. 
		'-Wunused-parameter'. 
		'-Wunused-variable'. 
		'-Wunused-value'. 
		'-Wsign-compare'. 
		'-DDEBUGVM=1'. 
		 '-DNDEBUG'.
		'-DEXTERNALPRIMSDEBUG=1'. 
		'-gdwarf-2' }