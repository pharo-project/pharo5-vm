simulation
newInputEventAccessorOfSize: numElements
	<doNotGenerate>
	self flag: #endianness.
	^(CPluggableAccessor on: (IntegerArray new: 16))
		atBlock: [:obj :idx| (obj at: idx - 1 * 2) + ((obj at: idx - 1 * 2 + 1) << 32)]
		atPutBlock: [:obj :idx :val|
					obj at: idx - 1 * 2 put: (val bitAnd: 16rFFFFFFFF).
					obj at: idx - 1 * 2 + 1 put: val >> 32.
					val]