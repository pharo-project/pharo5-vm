compiler flags
commonCompilerFlags
	"omit -ggdb2 to prevent generating debug info"
	"Some flags explanation: 
	
	STACK_ALIGN_BYTES=16 is needed in mingw and FFI (and I suppose on other modules too).
	DALLOCA_LIES_SO_USE_GETSP=0 Some compilers return the stack address+4 on alloca function, 
	then FFI module needs to adjust that. It is NOT the case of mingw.
	For more information see this thread: http://forum.world.st/There-are-something-fishy-with-FFI-plugin-td4584226.html
	"
	^ {  
		'-march=pentium'.
		'-mwindows'.
		'-D_MT'.
		'-mthreads'. 
		'-mwin32'.
		'-mno-rtd'. 
		'-mms-bitfields'. 
		'-mno-accumulate-outgoing-args ', self winVer.
		'-momit-leaf-frame-pointer'. 
		'-maccumulate-outgoing-args'. 
		'-funroll-loops'. 		
		'-falign-loops=16'. 
		'-falign-jumps=16'. 
		'-falign-functions=16'. 
		'-falign-labels=16'. 
		'-Dsetjmp=_setjmp'.		
		'-DWIN32'. 
		'-DWIN32_FILE_SUPPORT'. 
		'-DNO_ISNAN'.
		'-DNO_SERVICE'. 
		'-DNO_STD_FILE_SUPPORT'.
		'-DLSB_FIRST'. 
		'-DVM_NAME="', self executableName,'"'.
		'-DX86 '.
		'-DSTACK_ALIGN_BYTES=16'. 
		'-DALLOCA_LIES_SO_USE_GETSP=0'. 
		'-DENABLE_FAST_BLT'.
		'-D_USE_32BIT_TIME_T'.
		'-D_FILE_OFFSET_BITS=64'.
		'-D_GNU_SOURCE'.
		'-DNODBGPRINT' "Otherwise it redefines printf and compiler complains"}