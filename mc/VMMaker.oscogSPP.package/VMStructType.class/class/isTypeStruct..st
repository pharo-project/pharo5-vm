translation
isTypeStruct: type
	StructTypeNameCache ifNil:
		[StructTypeNameCache := Set new.
		 self allSubclassesDo:
			[:sc| StructTypeNameCache add: sc name; add: sc structTypeName]].
	^type notNil
	  and: [StructTypeNameCache anySatisfy:
			[:structType|
			type = structType]]