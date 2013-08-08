private
type: typeString subtype: subtypeString
"Associate this object instance with an instance of the generic scripting component.  Answer self."

	self 
		primOpenDefaultConfiguration: (DescType of: typeString)
		subtype: (DescType of: subtypeString)