cleanup obsolete classes
countReallyObsoleteClassesAndMetaclasses
	"Counting really obsolete classes and metaclasses"

	| metaSize classSize |
	Smalltalk garbageCollect.
	metaSize := self reallyObsoleteMetaclasses size.
	self  crTrace: 'Really obsolete metaclasses: ', metaSize printString.
	classSize := self reallyObsoleteClasses size.
	Transcript crTrace: 'Really obsolete classes: ', classSize printString; cr.
	"Metaclasses must correspond to classes!"
	metaSize ~= classSize 
		ifTrue: [self error: 'Serious metalevel inconsistency!!'].