settings
compilerFlagsDebug
	"NDEBUG is actually TRACE (for the trace vm), so it needs to be defined 
	 for debug (but undefinded for trace)"
	^#('-g3' '-O0' '-DDEBUGVM=1' '-DDEBUG=1' '-DNDEBUG')