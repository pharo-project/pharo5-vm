allocation
eeInstantiateSmallClass: classObj numSlots: numSlots
	| classIndex |
	<inline: true>
	classIndex := self ensureBehaviorHash: classObj.
	^self
		eeInstantiateClassIndex: classIndex
		format: (self instSpecOfClass: classObj)
		numSlots: numSlots