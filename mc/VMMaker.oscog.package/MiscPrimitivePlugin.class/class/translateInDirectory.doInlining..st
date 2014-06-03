translation
translateInDirectory: directory doInlining: inlineFlag
"handle a special case code string rather than normal generated code."
	| cg fname fstat reference |
	 fname := self moduleName, '.c'.

	reference := directory asFileReference / fname.
	fstat := reference exists ifTrue: [ reference entry ] ifFalse: [nil].
	fstat ifNotNil:[self timeStamp < fstat modificationTime asSeconds ifTrue:[^nil]].

	self initialize.
	cg := self buildCodeGeneratorUpTo: InterpreterPlugin.
	cg addMethodsForPrimitives: self translatedPrimitives.
	self storeString: cg generateCodeStringForPrimitives onFileNamed: (directory asFileReference / fname) fullName.
	^cg exportedPrimitiveNames asArray
