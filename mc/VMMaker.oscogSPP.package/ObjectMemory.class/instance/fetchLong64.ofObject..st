object access
fetchLong64: longIndex ofObject: oop
	<returnTypeC: #sqLong>
	^self cppIf: BytesPerWord = 8
		ifTrue: [self long64At: oop + self baseHeaderSize + (longIndex << 3)]
		ifFalse:
			["BEWARE OF SIGN EXTENSION ON LEAST SIGNIFICAND LIMB
			'unsigned int) CAST IS THERE TO PREVENT SUCH ERROR"
			self cppIf: VMBIGENDIAN
				ifTrue: [((self long32At: oop + self baseHeaderSize + (longIndex << 3)) asUnsignedLongLong << 32)
					+ (self cCoerceSimple: (self long32At: oop + self baseHeaderSize + (longIndex << 3 + 4)) to: #'unsigned int')]
				ifFalse: [(self cCoerceSimple: (self long32At: oop + self baseHeaderSize + (longIndex << 3)) to: #'unsigned int')
					+ ((self long32At: oop + self baseHeaderSize + (longIndex << 3 + 4)) asUnsignedLongLong << 32)]]