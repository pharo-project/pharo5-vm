instance creation
prototypeClassFor: type 
	| deepest |
	deepest := nil.
	self allSubclassesDo:
		[:aClass | aClass imageType = type ifTrue: [deepest := aClass]].
	^deepest