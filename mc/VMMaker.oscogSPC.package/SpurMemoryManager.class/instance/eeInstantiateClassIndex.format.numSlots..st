instantiation
eeInstantiateClassIndex: knownClassIndex format: objFormat numSlots: numSlots
	"Instantiate an instance of a compact class.  ee stands for execution engine and
	 implies that this allocation will *NOT* cause a GC.  N.B. the instantiated object
	 IS NOT FILLED and must be completed before returning it to Smalltalk. Since this
	 call is used in routines that do just that we are safe.  Break this rule and die in GC.
	 Result is guaranteed to be young."
	<api>
	<inline: true>
	self assert: (numSlots >= 0 and: [knownClassIndex ~= 0]).
	self assert: (objFormat < self firstByteFormat
					ifTrue: [objFormat]
					ifFalse: [objFormat bitAnd: self byteFormatMask])
				= (self instSpecOfClass: (self knownClassAtIndex: knownClassIndex)).
	^self allocateNewSpaceSlots: numSlots format: objFormat classIndex: knownClassIndex