primitive support
isNegativeIntegerValueOf: oop
	"Answer true if integer object is negative.
	Fail if object pointed by oop i not an integer."
	| ok smallInt |

	(objectMemory isIntegerObject: oop) ifTrue:
		[smallInt := objectMemory integerValueOf: oop.
		^smallInt < 0].
	
	(objectMemory isNonIntegerNonImmediate: oop) ifTrue:
		[ok := objectMemory isClassOfNonImm: oop
						equalTo: (objectMemory splObj: ClassLargePositiveInteger)
						compactClassIndex: ClassLargePositiveIntegerCompactIndex.
		 ok ifTrue: [^false].
			
		 ok := objectMemory isClassOfNonImm: oop
								equalTo: (objectMemory splObj: ClassLargeNegativeInteger)
								compactClassIndex: ClassLargeNegativeIntegerCompactIndex.
		 ok ifTrue: [^true]].
	self primitiveFail.
	^false