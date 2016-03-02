compiler flags
compilerFlagsDebug
	"Define NDEBUG for production to exclude asserts "
	^ {
		'-g3'. 
		'-O0'.
		'-march=pentium4'. 
		'-momit-leaf-frame-pointer'. 
		'-maccumulate-outgoing-args'. 
		'-funroll-loops'. 
		'-DNDEBUG'.
		'-DDEBUGVM=1'
	}