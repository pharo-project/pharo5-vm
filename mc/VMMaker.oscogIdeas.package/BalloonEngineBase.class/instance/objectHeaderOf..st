accessing objects
objectHeaderOf: obj

	^self makeUnsignedFrom:(self obj: obj at: GEObjectType)