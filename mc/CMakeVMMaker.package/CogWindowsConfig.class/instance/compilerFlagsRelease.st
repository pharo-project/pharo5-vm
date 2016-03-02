compiler flags
compilerFlagsRelease
	"Define NDEBUG for production to exclude asserts "
	^ {
		'-g0'. 
		'-O3'. 
		'-fprefetch-loop-arrays'.
		'-fno-omit-frame-pointer'. 
		'-finline-functions'. 
		'-DNDEBUG'.
		'-DDEBUGVM=0'.
		}