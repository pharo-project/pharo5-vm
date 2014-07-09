compact classes
becomeCompact: aClass simplyAt: index
	"The same as #becomeCompact: but without updating the instances."

	| compactClassesArray |
	aClass isWeak 
		ifTrue: [^ self error: 'You must not make a weak class compact'].
	compactClassesArray := Smalltalk compactClassesArray.
	(aClass isCompact or: [compactClassesArray includes: aClass])
		ifTrue: [^ self error: aClass name, 'is already compact'].		
	(compactClassesArray at: index) ifNotNil: [^ self error: 'compact table slot already in use'].
	"Install this class in the compact class table"
	compactClassesArray at: index put: aClass.
	"Update instspec so future instances will be compact"
	aClass setFormat: aClass format + (index bitShift: 11).
	"Caller must convert the instances"
