instantiation
eeInstantiateSmallClass: classObj numSlots: numSlots
	"Instantiate an instance of a class, with only a few slots.  ee stands for execution
	 engine and implies that this allocation will *NOT* cause a GC.  N.B. the instantiated
	 object IS NOT FILLED and must be completed before returning it to Smalltalk. Since
	 this call is used in routines that do just that we are safe.  Break this rule and die in GC.
	 Result is guaranteed to be young.  We assume this is only used on classes that are
	 already in the class table."
	<inline: true>
	self assert: (self rawHashBitsOf: classObj) ~= 0.
	^self
		eeInstantiateSmallClassIndex: (self rawHashBitsOf: classObj)
		format: (self instSpecOfClass: classObj)
		numSlots: numSlots