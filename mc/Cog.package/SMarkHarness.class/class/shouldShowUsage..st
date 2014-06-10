helper
shouldShowUsage: arguments
	
	arguments size < 2 ifTrue: [^ true ].
	
	^ arguments anySatisfy: [:elem | (elem = '--help') or: [elem = '-?'] ].  