instantiation
eeInstantiateSmallClass: classObj numSlots: numSlots
	"Instantiate an instance of a class, with only a few slots.  ee stands for execution
	 engine and implies that this allocation will *NOT* cause a GC.  N.B. the instantiated
	 object IS NOT FILLED and must be completed before returning it to Smalltalk. Since
	 this call is used in routines that do just that we are safe.  Break this rule and die in GC.
	 Result is guaranteed to be young."
	| classIndex |
	<inline: true>
	classIndex := self ensureBehaviorHash: classObj.
	^self
		eeInstantiateSmallClassIndex: classIndex
		format: (self instSpecOfClass: classObj)
		numSlots: numSlots