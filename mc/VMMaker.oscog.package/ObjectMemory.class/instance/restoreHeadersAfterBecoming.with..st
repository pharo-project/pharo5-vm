become
restoreHeadersAfterBecoming: list1 with: list2 
	"Restore the headers of all oops in both lists. Exchange their hash bits so
	becoming objects in identity sets and dictionaries doesn't change their
	hash value."
	"See also prepareForwardingTableForBecoming:with:woWay: for notes
	regarding the case
	of oop1 = oop2"
	| fieldOffset oop1 oop2 hdr1 hdr2 |
	fieldOffset := self lastPointerOf: list1.
	[fieldOffset >= self baseHeaderSize]
		whileTrue: [oop1 := self longAt: list1 + fieldOffset.
			oop2 := self longAt: list2 + fieldOffset.
			oop1 = oop2
				ifFalse: [self restoreHeaderOf: oop1.
					self restoreHeaderOf: oop2.
					"Exchange hash bits of the two objects."
					hdr1 := self longAt: oop1.
					hdr2 := self longAt: oop2.
					self
						longAt: oop1
						put: ((hdr1 bitAnd: AllButHashBits) bitOr: (hdr2 bitAnd: HashBits)).
					self
						longAt: oop2
						put: ((hdr2 bitAnd: AllButHashBits) bitOr: (hdr1 bitAnd: HashBits))].
			fieldOffset := fieldOffset - self wordSize]