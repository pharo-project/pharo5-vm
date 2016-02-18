as yet unclassified
compilerFlagsRelease

	^ {
		'-g0'. 
		'-O2'. 
		'-msse2'. 
		'-DNDEBUG'. 
		'-DITIMER_HEARTBEAT=1'. 
		'-DNO_VM_PROFILE=1'. 
		'-DDEBUGVM=0'. 
		'-DNOEXECINFO' }
