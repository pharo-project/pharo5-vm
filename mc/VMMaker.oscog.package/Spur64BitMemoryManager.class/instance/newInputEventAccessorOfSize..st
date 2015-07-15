simulation
newInputEventAccessorOfSize: numElements
	<doNotGenerate>
	self flag: #endianness.
	^(CPluggableAccessor on: (WordArray new: 16))
		atBlock: [:obj :idx| | v |
				v := (obj at: idx - 1 * 2 + 1) + ((obj at: idx - 1 * 2 + 2) << 32).
				v >> 63 > 0 ifTrue:
					[v := v - (1 << 64)].
				v]
		atPutBlock: [:obj :idx :val|
					obj at: idx - 1 * 2 + 1 put: (val bitAnd: 16rFFFFFFFF).
					obj at: idx - 1 * 2 + 2 put: (val >> 32 bitAnd: 16rFFFFFFFF).
					val];
		objectSize: 8