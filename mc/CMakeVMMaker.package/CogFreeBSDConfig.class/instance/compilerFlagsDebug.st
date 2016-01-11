as yet unclassified
compilerFlagsDebug

	^ {
		'-g3'. 
		'-O0'. 
		'-msse2'. 
		'-DITIMER_HEARTBEAT=1'. 
		'-DNO_VM_PROFILE=1'. 
		'-DDEBUGVM=1'. 
		'-DNDEBUG'.
		'-DNOEXECINFO' }