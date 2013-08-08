cmake commands
setTargetProperty: propertyString toString: aString
	self 
		cmd: 'set_target_properties'
		params: (String streamContents: [ :stream |
			stream 
				nextPutAll: self moduleName;
				nextPutAll: ' PROPERTIES ';
				nextPutAll: propertyString;
				space;
				nextPut: $";  
				nextPutAll: (aString copyReplaceAll: '"' with: '\"');
				nextPut: $"
				 ])