compact classes
becomeUncompact: aClass
	"The inverse of #becomeCompact. However, some classes can not be uncompact: see #checkCanBeUncompact."

	| compactClassesArray index |
	compactClassesArray := Smalltalk compactClassesArray.
	(index := aClass indexIfCompact) = 0
		ifTrue: [^ self].
	self assert: [compactClassesArray includes: aClass].
	aClass checkCanBeUncompact.
	"Update instspec so future instances will not be compact"
	aClass setFormat: aClass format - (index bitShift: 11).
	"Make up new instances and become old ones into them"
	aClass updateInstancesFrom: aClass.
	"Make sure there are no compact ones left around"
	Smalltalk garbageCollect.
	"Remove this class from the compact class table"
	compactClassesArray at: index put: nil.
