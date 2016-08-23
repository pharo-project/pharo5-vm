trampolines
ceNewArraySlotSize: slotSize
	<api>
	<option: #SqueakV3ObjectMemory>
	objectMemory hasSpurMemoryManagerAPI ifTrue:
		[| obj |
		 obj := objectMemory
					eeInstantiateSmallClassIndex: ClassArrayCompactIndex
					format: objectMemory arrayFormat
					numSlots: slotSize.
		objectMemory fillObj: obj numSlots: slotSize with: objectMemory nilObject.
		^obj].
	^objectMemory
		eeInstantiateAndInitializeClass: (objectMemory splObj: ClassArray)
		indexableSize: slotSize