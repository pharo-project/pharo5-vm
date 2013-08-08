cmake commands
addXCodeProperty: propertyString value: valueString 
	self 
		addProperty: 'XCODE_ATTRIBUTE_' , propertyString 
		value: valueString
