instantiation
fillObj: objOop numSlots: numSlots with: fillValue
	<inline: true>
	<var: #p type: #usqInt>
	self assert: (self oop: objOop + self baseHeaderSize + (numSlots * self bytesPerSlot) - 1
					isLessThan: (self addressAfter: objOop)).
	(objOop + self baseHeaderSize) asUnsignedInteger
		to: (objOop + self baseHeaderSize + (numSlots * self bytesPerSlot) - 1) asUnsignedInteger
		by: self allocationUnit
		do: [:p| self longAt: p put: fillValue]