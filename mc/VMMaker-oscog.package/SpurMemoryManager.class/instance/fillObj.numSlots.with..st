allocation
fillObj: objOop numSlots: numSlots with: fillValue
	objOop + self baseHeaderSize
		to: objOop + self baseHeaderSize + (numSlots * self bytesPerOop) - 1
		by: self allocationUnit
		do: [:p|
			self assert: p < (self addressAfter: objOop).
			self longAt: p put: fillValue;
				longAt: p + 4 put: fillValue]