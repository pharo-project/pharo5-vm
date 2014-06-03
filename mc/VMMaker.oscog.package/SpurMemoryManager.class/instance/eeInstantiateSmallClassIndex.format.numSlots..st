instantiation
eeInstantiateSmallClassIndex: knownClassIndex format: objFormat numSlots: numSlots
	"Instantiate a small instance of a compact class.  ee stands for execution engine and
	 implies that this allocation will *NOT* cause a GC.  small implies the object will have
	 less than 255 slots. N.B. the instantiated object IS NOT FILLED and must be completed
	 before returning it to Smalltalk. Since this call is used in routines that do just that we
	 are safe.  Break this rule and die in GC.  Result is guaranteed to be young."
	<inline: true>
	self assert: (numSlots >= 0 and: [knownClassIndex ~= 0]).
	self assert: (objFormat < self firstByteFormat
					ifTrue: [objFormat]
					ifFalse: [objFormat bitAnd: self byteFormatMask])
				= (self instSpecOfClass: (self knownClassAtIndex: knownClassIndex)).
	^self allocateSmallNewSpaceSlots: numSlots format: objFormat classIndex: knownClassIndex