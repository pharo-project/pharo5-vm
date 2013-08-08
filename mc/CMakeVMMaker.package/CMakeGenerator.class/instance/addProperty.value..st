cmake commands
addProperty: propertyString value: valueString 
	self puts: 'set_target_properties(' , self moduleName , ' PROPERTIES ' , propertyString , ' "' , valueString, '")'
