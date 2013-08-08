private
targetedDeviceFamilyAsString 
	^String streamContents: [ :stream | 
		self targetedDeviceFamily 
			do: [ :each | stream nextPutAll: each asString ]
			separatedBy: [ stream nextPut: $, ].
		stream nextPut: Character space ]