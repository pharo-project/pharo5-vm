translation
structTargetKindForType: type
	StructTypeNameCache ifNil:
		[StructTypeNameCache := Set new.
		 self allSubclassesDo:
			[:sc| StructTypeNameCache add: sc name; add: sc structTypeName ]].
	^(type notNil
	   and: [StructTypeNameCache anySatisfy:
			[:structType|
			(type beginsWith: structType)
			and: [type size = structType size
				or: [(type at: structType size + 1) isAlphaNumeric not]]]]) ifTrue:
		[(type includes: $*)
			ifTrue: [#pointer]
			ifFalse: [#struct]]