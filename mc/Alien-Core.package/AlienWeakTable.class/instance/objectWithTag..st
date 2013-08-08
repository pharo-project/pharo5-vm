accessing
objectWithTag: aTag
	^ accessProtect critical: 
		[ weakArray at: (strongArray 
				indexOf: aTag
				ifAbsent: [ ^ nil ]) ]