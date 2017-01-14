cog jit support
eeInstantiateClassIndex: knownClassIndex format: objFormat numSlots: numSlots
	self assert: knownClassIndex = ClassArrayCompactIndex.
	^self oopForObject: (Array new: numSlots)