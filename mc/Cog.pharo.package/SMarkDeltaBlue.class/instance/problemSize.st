accessing
problemSize
	<omniUnenforced> "Hint for the OMOP that it is part of the meta infrastructure"
	| ps |
	ps := super problemSize.
	
	ps isInteger ifFalse: [	^ self defaultProblemSize].
		
	^ ps