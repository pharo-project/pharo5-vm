patching
patchForPackage: package withPatches: patches snapshot: snapshot
	(package includesClass: Character) ifTrue:
		[patches
			addAll: ((self modifiedCharacterDefinitionsIn: snapshot definitions)
						select:
							[:def|
							 patches noneSatisfy:
								[:addition|
								def isMethodDefinition
								and: [addition definition selector = def selector
								and: [addition definition className = def className
								and: [addition definition classIsMeta = def classIsMeta]]]]]
						thenCollect:
							[:def|
							 ((def source includesSubString: 'DELETEME')
								ifTrue: [MCRemoval]
								ifFalse: [MCAddition]) of: def]);
			add: (self immediateClassDefinitionFor: #Character from: snapshot definitions)].
	(package includesClass: SmallInteger) ifTrue:
		[patches
			add: (self immediateClassDefinitionFor: #SmallInteger from: snapshot definitions)].
	^MCPatch operations: patches