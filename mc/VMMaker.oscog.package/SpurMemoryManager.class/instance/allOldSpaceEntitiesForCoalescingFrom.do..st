object enumeration
allOldSpaceEntitiesForCoalescingFrom: firstObj do: aBlock
	<inline: true>
	| prevObj prevPrevObj objOop rawNumSlots rawNumSlotsAfter |
	prevPrevObj := prevObj := nil.
	objOop := firstObj.
	[self assert: objOop \\ self allocationUnit = 0.
	 self oop: objOop isLessThan: endOfMemory] whileTrue:
		[self assert: (self long64At: objOop) ~= 0.
		 rawNumSlots := self rawNumSlotsOf: objOop.
		 aBlock value: objOop.
		 "If the number of slot changes coalescing changed an object from a single to a double header.
		  In future have the block return the vaue.  It should know when things change."
		 self flag: 'future work'.
		 rawNumSlotsAfter := self rawNumSlotsOf: objOop.
		 (rawNumSlotsAfter ~= rawNumSlots
		  and: [rawNumSlotsAfter = self numSlotsMask]) ifTrue:
			[objOop := objOop + self baseHeaderSize.
			 self assert: (self objectAfter: prevObj limit: endOfMemory) = objOop].
		 prevPrevObj := prevObj.
		 prevObj := objOop.
		 objOop := self objectAfter: objOop limit: endOfMemory].
	self touch: prevPrevObj.
	self touch: prevObj