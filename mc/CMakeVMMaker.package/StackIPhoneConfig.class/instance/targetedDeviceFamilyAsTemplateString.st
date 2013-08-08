private
targetedDeviceFamilyAsTemplateString 
	^String streamContents: [ :stream | 
		self targetedDeviceFamily do: [ :each | 
			stream 
				nextPutAll: '<integer>';
				nextPutAll: each asString;
				nextPutAll: '</integer>' ] ]