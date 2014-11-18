stack pages
highBit: anUnsignedValue 
	"This is a C implementation needed by ioSetMaxExtSemTableSize
	 and e.g. stackPageByteSize."
	| shifted bitNo |
	<api>
	<highBit> "so it shows up in senders..."
	<var: #anUnsignedValue type: #usqInt>
	<var: #shifted type: #usqInt>
	shifted := anUnsignedValue.
	bitNo := 0.
	self cppIf: objectMemory wordSize > 4
		ifTrue:
			[shifted < (1 << 32) ifFalse:
				[shifted := shifted >> 32.
				 bitNo := bitNo + 32]].
	shifted < (1 << 16) ifFalse:
		[shifted := shifted >> 16.
		 bitNo := bitNo + 16].
	shifted < (1 << 8) ifFalse:
		[shifted := shifted >> 8.
		 bitNo := bitNo + 8].
	shifted < (1 << 4) ifFalse:
		[shifted := shifted >> 4.
		 bitNo := bitNo + 4].
	shifted < (1 << 2) ifFalse:
		[shifted := shifted >> 2.
		 bitNo := bitNo + 2].
	shifted < (1 << 1) ifFalse:
		[shifted := shifted >> 1.
		 bitNo := bitNo + 1].
	"shifted 0 or 1 now"
	^bitNo + shifted