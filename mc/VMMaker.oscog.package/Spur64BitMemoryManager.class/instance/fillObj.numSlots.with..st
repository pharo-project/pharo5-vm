instantiation
fillObj: objOop numSlots: numSlots with: fillValue
	<inline: true>
	self assert: (self oop: objOop + self baseHeaderSize + (numSlots * self bytesPerSlot) - 1
					isLessThan: (self addressAfter: objOop)).
	objOop + self baseHeaderSize
		to: objOop + self baseHeaderSize + (numSlots * self bytesPerSlot) - 1
		by: self allocationUnit
		do: [:p| self longAt: p put: fillValue]