cmake commands
setTargetProperty: propertyString to: aString
	self 
		cmd: 'set_target_properties'
		params: (String streamContents: [ :stream |
			stream 
				nextPutAll: self moduleName;
				nextPutAll: ' PROPERTIES ';
				nextPutAll: propertyString;
				space;  
				nextPutAll: aString ])