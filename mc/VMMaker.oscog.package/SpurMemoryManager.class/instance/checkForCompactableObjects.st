debug support
checkForCompactableObjects
	"self checkForCompactableObjects"
	<doNotGenerate>
	| firstFree them sizes |
	firstFree := 0.
	self allOldSpaceEntitiesDo: [:o| (firstFree = 0 and: [self isFreeObject: o]) ifTrue: [firstFree := o]].
	firstFree = 0 ifTrue: [^nil].
	sizes := Bag new.
	self allFreeObjectsDo:
		[:f| sizes add: (self bytesInObject: f)].
	them := OrderedCollection new.
	self allOldSpaceObjectsFrom: firstFree do:
		[:o| | b |
		b := self bytesInObject: o.
		(sizes includes: b) ifTrue:
			[them add: o.
			 sizes remove: b]].
	^them isEmpty ifFalse:
		[{them size. them first. them last}]