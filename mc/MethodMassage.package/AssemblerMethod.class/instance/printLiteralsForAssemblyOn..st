printing
printLiteralsForAssemblyOn: aStream
	| literalsToDefine |
	literalsToDefine := literals copy asOrderedCollection.
	(literalsToDefine last isVariableBinding
	 and: [literalsToDefine last value = methodClass]) ifTrue:
		[literalsToDefine removeLast.
		 self assert: literalsToDefine last == selector.
		 literalsToDefine removeLast].
	literalsToDefine do:
		[:litOrBinding|
		aStream crtab.
		litOrBinding isLiteral
			ifTrue: [aStream nextPutAll: 'literal: '; print: litOrBinding]
			ifFalse: [aStream nextPutAll: 'binding: '; store: litOrBinding key].
		aStream nextPut: $;]