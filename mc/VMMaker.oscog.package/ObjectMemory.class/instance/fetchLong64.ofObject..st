object access
fetchLong64: longIndex ofObject: oop
	<returnTypeC: #sqLong>
	^self cppIf: BytesPerWord = 8
		ifTrue: [self long64At: oop + self baseHeaderSize + (longIndex << 3)]
		ifFalse:
			[self cppIf: VMBIGENDIAN
				ifTrue: [((self long32At: oop + self baseHeaderSize + (longIndex << 3)) asUnsignedLongLong << 32)
					+ (self long32At: oop + self baseHeaderSize + (longIndex << 3 + 4))]
				ifFalse: [(self long32At: oop + self baseHeaderSize + (longIndex << 3))
					+ ((self long32At: oop + self baseHeaderSize + (longIndex << 3 + 4)) asUnsignedLongLong << 32)]]