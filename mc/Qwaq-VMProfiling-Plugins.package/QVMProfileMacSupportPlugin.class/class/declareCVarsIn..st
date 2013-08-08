translation
declareCVarsIn: aCCodeGen
	aCCodeGen
		addHeaderFile: '<stdlib.h>';
		addHeaderFile: '<mach-o/dyld.h>';
		addHeaderFile: '<mach-o/getsect.h>'