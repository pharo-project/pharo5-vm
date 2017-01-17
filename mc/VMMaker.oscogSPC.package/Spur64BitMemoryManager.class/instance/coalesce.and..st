gc - global
coalesce: obj1 and: obj2
	| header1NumSlots header2NumSlots obj2slots newNumSlots |
	header1NumSlots := self rawNumSlotsOf: obj1.
	header2NumSlots := self rawNumSlotsOf: obj2.

	"compute total number of slots in obj2, including header"
	obj2slots := header2NumSlots = self numSlotsMask
					ifTrue: [(self rawOverflowSlotsOf: obj2) + (2 * self baseHeaderSize / self wordSize)]
					ifFalse: [(header2NumSlots = 0 ifTrue: [1] ifFalse: [header2NumSlots]) + (self baseHeaderSize / self wordSize)].
	self assert: obj2slots * self wordSize = (self bytesInObject: obj2).

	"if obj1 already has a double header things are simple..."
	header1NumSlots = self numSlotsMask ifTrue:
		[self rawOverflowSlotsOf: obj1 put: obj2slots + (self rawOverflowSlotsOf: obj1).
		 ^obj1].

	"compute total number of slots in obj1, excluding header"
	header1NumSlots := header1NumSlots = 0 ifTrue: [1] ifFalse: [header1NumSlots].
	self assert: header1NumSlots * self wordSize + self baseHeaderSize = (self bytesInObject: obj1).
	newNumSlots := obj2slots + header1NumSlots.

	"if obj1 still only requires a single header things are simple..."
	newNumSlots < self numSlotsMask ifTrue:
		[self rawNumSlotsOf: obj1 put: newNumSlots.
		 ^obj1].

	"convert from single to double header..."
	newNumSlots := newNumSlots - (self baseHeaderSize / self wordSize).
	self
		rawNumSlotsOf: obj1 + self baseHeaderSize put: self numSlotsMask;
		rawOverflowSlotsOf: obj1 + self baseHeaderSize put: newNumSlots.
	^obj1 + self baseHeaderSize