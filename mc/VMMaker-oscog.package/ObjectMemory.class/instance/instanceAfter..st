object enumeration
instanceAfter: objectPointer 
	"Support for instance enumeration. Return the next instance 
	of the class of the given object, or nilObj if the enumeration 
	is complete."
	| classPointer thisObj thisClass |
	classPointer := self fetchClassOfNonInt: objectPointer.
	thisObj := self accessibleObjectAfter: objectPointer.
	[thisObj = nil] whileFalse:
		[thisClass := self fetchClassOfNonInt: thisObj.
		 thisClass = classPointer ifTrue: [^ thisObj].
		 thisObj := self accessibleObjectAfter: thisObj].
	^ nilObj