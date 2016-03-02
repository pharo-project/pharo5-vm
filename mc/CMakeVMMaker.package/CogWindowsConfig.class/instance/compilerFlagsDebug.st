compiler flags
compilerFlagsDebug
	"Define NDEBUG for production to exclude asserts "
	^ {
		'-g3'. 
		'-O0'.
		'-DNDEBUG'.
		'-DDEBUGVM=1'
	}