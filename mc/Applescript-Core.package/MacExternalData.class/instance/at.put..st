accessing
at: index put: datum

	datum >= 0 ifTrue: [^super at: index put: datum].		
	^super at: index put: (16rFFFFFFFF + datum + 1)