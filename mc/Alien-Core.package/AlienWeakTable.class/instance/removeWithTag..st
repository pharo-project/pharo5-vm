removing
removeWithTag: aTag 
	| i |
	accessProtect critical: 
		[ i := strongArray 
			indexOf: aTag
			ifAbsent: [ ^ nil ].
		strongArray 
			at: i
			put: nil.
		weakArray 
			at: i
			put: nil.
		i = lastUsedIndex ifTrue: [ lastUsedIndex := i - 1 ] ]