C translation
withOptionalVerbiageFor: selector on: aStream do: mainBlock
	^ self 
		withOptionalVerbiageFor: selector 
		on: aStream 
		do: mainBlock 
		ifOptionalDo: nil		