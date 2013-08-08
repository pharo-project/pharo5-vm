translation
declareHeaderFilesIn: aCCodeGenerator
	self hasHeaderFile ifTrue:[
		aCCodeGenerator addHeaderFile: '"', self moduleName,'.h"'].