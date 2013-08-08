accessing objects
objectTypeOf: obj

	^(self makeUnsignedFrom:(self obj: obj at: GEObjectType)) bitAnd: GEPrimitiveTypeMask