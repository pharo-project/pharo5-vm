testing
testLittleEndianBitmap32BitLongs
	"Test that LittleEndianBitmap provides little-endian access for 32-bit accessors"
	| memory |
	memory := LittleEndianBitmap new: 64.
	0 to: 30 do:
		[:shift|
		#(-1 1) do:
			[:initial| | value |
			value := initial bitShift: shift.
			memory longAt: 1 put: value.
			self assert: value equals: (memory longAt: 1).
			memory
				longAt: 5 put: 16r55550000;
				longAt: 9 put: 16r00005555.
			self assert: 16r55555555 equals: (memory longAt: 7).
			memory longAt: 7 put: value.
			self assert: value equals: (memory longAt: 7).
			self assert: 0 equals: (memory at: (shift <= 15 = (initial >= 0) ifTrue: [9] ifFalse: [5]))]].
	31 to: 32 do:
		[:shift|
		self should: [memory longAt: 1 put: -1 << shift - 1] raise: Error.
		self should: [memory longAt: 1 put: 1 << shift] raise: Error].
	0 to: 31 do:
		[:shift| | value |
		value := 1 bitShift: shift.
		memory unsignedLongAt: 1 put: value.
		self assert: value equals: (memory unsignedLongAt: 1).
		memory
				longAt: 5 put: 16r55550000;
				longAt: 9 put: 16r00005555.
		self assert: 16r55555555 equals: (memory unsignedLongAt: 7).
		memory unsignedLongAt: 7 put: value.
		self assert: value equals: (memory unsignedLongAt: 7).
		self assert: 0 equals: (memory at: (shift <= 15 ifTrue: [9] ifFalse: [5]))].
	self should: [memory unsignedLongAt: 1 put: -1] raise: Error.
	32 to: 33 do:
		[:shift|
		self should: [memory unsignedLongAt: 1 put: 1 << shift] raise: Error]