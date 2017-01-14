translation
structTargetKindForDeclaration: decl
	StructTypeNameCache ifNil:
		[StructTypeNameCache := Set new.
		 self allSubclassesDo:
			[:sc| StructTypeNameCache add: sc name; add: sc structTypeName ]].
	^(decl notNil
	   and: [(StructTypeNameCache includes: decl)
			or: [StructTypeNameCache anySatisfy:
					[:structType|
					(decl beginsWith: structType)
					and: [(decl indexOf: $* ifAbsent: [decl indexOf: Character space]) > structType size]]]]) ifTrue:
		[(decl indexOf: $*) > 0
			ifTrue: [#pointer]
			ifFalse: [#struct]]