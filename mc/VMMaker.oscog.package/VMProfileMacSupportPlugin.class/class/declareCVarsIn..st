translation
declareCVarsIn: aCCodeGen
	aCCodeGen
		addHeaderFile: '<dlfcn.h>';
		addHeaderFile: '<mach-o/dyld.h>';
		addHeaderFile: '<mach-o/getsect.h>'