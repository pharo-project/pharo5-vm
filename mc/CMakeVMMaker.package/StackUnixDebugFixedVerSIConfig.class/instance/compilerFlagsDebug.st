as yet unclassified
compilerFlagsDebug

	^ {
		'-g3'. 
		'-O0'. 
		'-msse2'. 
		'-save-temps'. 
		'-D_GNU_SOURCE'. 
		'-DITIMER_HEARTBEAT=1'. 
		'-DNO_VM_PROFILE=1'. 
		'-DCOGMTVM=0'. 
		'-DDEBUGVM=1'.
		'-DNDEBUG' }