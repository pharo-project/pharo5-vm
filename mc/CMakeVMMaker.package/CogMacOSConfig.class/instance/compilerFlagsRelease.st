compiler flags
compilerFlagsRelease
" -mdynamic-no-pic "
	^ {
		'-gdwarf-2'. 
		'-O3'. 
		'-funroll-loops'. 
		'-ftree-vectorize'. 
		'-msse3'. 
		'-DDEBUGVM=0'. 
		'-DNDEBUG'. 
		'-Wunused-value'. 
		'-Wuninitialized'. 
		'-falign-functions=16'. 
		'-fno-gcse'. 
		'-mtune=prescott'. 
		'-march=pentium-m'. 
		'-mfpmath=sse'. 
		'-finline-functions'. 
		'-Wall'. 
		'-DUSE_INLINE_MEMORY_ACCESSORS' }