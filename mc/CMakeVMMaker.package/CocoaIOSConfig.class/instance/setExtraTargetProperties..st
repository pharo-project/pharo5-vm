settings
setExtraTargetProperties: maker
	| plist precompiledHeaders |

	" generated and add Info.plist file "
	plist := self plistFile.	

	(maker buildDir forceNewFileNamed: 'Info.plist') 
		nextPutAll: plist; 
		close.

	maker 
		addProperty: 'MACOSX_BUNDLE_INFO_PLIST' 
		value: '${buildDir}/Info.plist'.  

	maker 
		cmd: 'set_source_files_properties' 
		params: '${resources} PROPERTIES MACOSX_PACKAGE_LOCATION Resources'.
			
	precompiledHeaders := (self executableName, '_Prefix.pch').
	(maker buildDir forceNewFileNamed: precompiledHeaders) 
		nextPutAll: self precompiledHeaders;
		close.

	maker addXCodeProperty: 'GCC_PREFIX_HEADER' value: '${buildDir}/', precompiledHeaders.	

	"maker 
		addXCodeProperty: 'GCC_ENABLE_SSE3_EXTENSIONS' value: 'YES';  
		addXCodeProperty: 'GCC_ENABLE_SSE41_EXTENSIONS' value: 'YES';
		addXCodeProperty: 'GCC_ENABLE_SSE42_EXTENSIONS' value: 'YES';
		addXCodeProperty: 'GCC_GENERATE_DEBUGGING_SYMBOLS' value: 'NO';  
		addXCodeProperty: 'GCC_INLINES_ARE_PRIVATE_EXTERN' value: 'YES';
		addXCodeProperty: 'GCC_UNROLL_LOOPS' value: 'YES'.	"
	
	"Extras"
	maker 
		addXCodeProperty: 'ICC_DEBUG' value: 'NO';
		addXCodeProperty: 'ICC_OPTLEVEL' value: 'speedHLO';
		addXCodeProperty: 'ICC_OPT_IPO_FOR_SINGLE_FILE_COMPILATION' value: 'YES';
		addXCodeProperty: 'ICC_OPT_PARALLEL' value: 'NO';
		addXCodeProperty: 'ICC_OPT_PREFETCH_INSERTION' value: 'YES';
		addXCodeProperty: 'ICC_OPT_PROVIDE_FRAME_PTR' value: 'NO';
		addXCodeProperty: 'ICC_OPT_USE_ARCH_IA32' value: 'SSE41';
		addXCodeProperty: 'PER_ARCH_CFLAGS_i386' value: '-finline-functions -mfpmath=sse -march=pentium-m -mtune=prescott -falign-functions=16  -fno-gcse -DLSB_FIRST';
		addXCodeProperty: 'PER_ARCH_CFLAGS_ppc' value: '-fast -mtune=7450 -mcpu=7450 -D_BSD_SOCKLEN_T_=int'