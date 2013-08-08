cmake commands
setTargetProperty: propertyString toAll: aCollection
	^self 
		setTargetProperty: propertyString 
		to: (String streamContents: [ :stream | 
			aCollection 
				do: [ :each | stream nextPutAll: each ]
				separatedBy: [ stream nextPut: $, ] ])