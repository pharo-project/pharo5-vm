compiler flags
compilerFlagsRelease
	"Define NDEBUG for production to exclude asserts "
	^ {
		'-g0'. 
		'-O2'. 
		'-march=pentium4'. 
		'-momit-leaf-frame-pointer'. 
		'-maccumulate-outgoing-args'. 
		'-funroll-loops'.
		'-DNDEBUG -DDEBUGVM=0'}