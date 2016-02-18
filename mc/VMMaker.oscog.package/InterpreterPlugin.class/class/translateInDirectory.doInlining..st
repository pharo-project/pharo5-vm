translation
translateInDirectory: directory doInlining: inlineFlag
"This is the default method for writing out sources for a plugin. Several classes need special handling, so look at all implementors of this message"
	| cg fname |
	 fname := self moduleName, '.c'.

	"don't translate if the file is newer than my timeStamp"
	(directory entryAt: fname ifAbsent: nil) ifNotNil:
		[:fstat| | mTime |
		mTime := fstat modificationTime.
		mTime isInteger ifFalse: [mTime := mTime asSeconds].
		 (self allCodeOlderThan: mTime) ifTrue:
			[^nil]].

	self initialize.
	cg := self buildCodeGenerator.
	cg inferTypesForImplicitlyTypedVariablesAndMethods.
	self pruneUnusedInterpreterPluginMethodsIn: cg.
	cg storeCodeOnFile:  (directory fullNameFor: fname) doInlining: inlineFlag.
	^cg exportedPrimitiveNames asArray