compiler flags
commonCompilerFlags

	"Common compiler flags"
	
	^ { 
		'-fmessage-length=0'.
		'-Wno-trigraphs'. 
		'-fpascal-strings'. 
		'-fasm-blocks'. 
		'-DCOGMTVM=1'.
		'-DUSE_GLOBAL_STRUCT=0'.
		'-DTARGET_API_MAC_CARBON'.
		'-DHAVE_SYS_TIME_H'.
		'-mmacosx-version-min=10.5' }