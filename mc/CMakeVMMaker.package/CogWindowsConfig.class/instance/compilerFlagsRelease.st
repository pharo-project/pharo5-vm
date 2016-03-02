compiler flags
compilerFlagsRelease
	"Define NDEBUG for production to exclude asserts "
	^ {
		'-g0'. 
		'-momit-leaf-frame-pointer'.
		'-maccumulate-outgoing-args'. 
		'-funroll-loops'.
		'-DNDEBUG'.
		'-DDEBUGVM=0'.
		'-O3'. 
		'-fprefetch-loop-arrays'.
		'-fno-omit-frame-pointer'. 
		'-finline-functions'. 
		}