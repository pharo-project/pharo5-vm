translation
declareCVarsIn: aCCodeGenerator
	self declareCAsOop: (self instVarNames select: [:iv| iv endsWith: 'Object']) in: aCCodeGenerator.
	aCCodeGenerator
		var: 'savedFirstFieldsSpace' type: #SpurContiguousObjStack