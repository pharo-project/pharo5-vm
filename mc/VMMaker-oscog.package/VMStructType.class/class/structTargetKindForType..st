translation
structTargetKindForType: type
	| index |
	StructTypeNameCache ifNil:
		[StructTypeNameCache := Set new.
		 self allSubclassesDo:
			[:sc| StructTypeNameCache add: sc name; add: sc structTypeName ]].
	^(type notNil
	   and: [StructTypeNameCache anySatisfy:
			[:structType|
			(type beginsWith: structType)
			and: [index > structType size]]]) ifTrue:
		[(index := type indexOf: $*) > 0
			ifTrue: [#pointer]
			ifFalse: [#struct]]