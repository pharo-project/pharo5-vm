translation
declareCVarsIn: aCCodeGen
	aCCodeGen
		addHeaderFile: '<setjmp.h>';
		addHeaderFile: '"vmCallback.h"';
		addHeaderFile: '"ia32abi.h"'