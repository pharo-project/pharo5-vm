compact classes
becomeCompact: aClass
	"Make the class compact.
	This means: 
	- find a free slot in 'Smalltalk compactClassArray'
	- add the class in that array
	- update the format of the class with the index
	- update the instances of the class
	"
	| compactClassesArray index |

	aClass isWeak ifTrue: [^ self error: 'You must not make a weak class compact'].
	compactClassesArray := Smalltalk compactClassesArray.
	(aClass isCompact or: [compactClassesArray includes: aClass])
		ifTrue: [^ self error: aClass name , 'is already compact'].
	index := compactClassesArray indexOf: nil
		ifAbsent: [^ self error: 'compact class table is full'].
	"Install this class in the compact class table"
	compactClassesArray at: index put: aClass.
	"Update instspec so future instances will be compact"
	aClass setFormat: aClass format + (index bitShift: 11).
	"Make up new instances and become old ones into them"
	aClass updateInstancesFrom: aClass.
	"Purge any old instances"
	Smalltalk garbageCollect.