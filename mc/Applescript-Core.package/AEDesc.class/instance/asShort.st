converting
asShort

	^(self primAEDescToString: (ByteArray new: 2))
		shortAt: 1 bigEndian: true