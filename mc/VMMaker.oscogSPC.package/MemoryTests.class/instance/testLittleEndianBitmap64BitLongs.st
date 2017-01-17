testing
testLittleEndianBitmap64BitLongs
	"Test that Bitmap provides little-endian access for 64-bit accessors"
	| memory |
	memory := LittleEndianBitmap new: 64.
	0 to: 62 do:
		[:shift|
		#(-1 1) do:
			[:initial| | value |
			value := initial bitShift: shift.
			memory long64At: 1 put: value.
			self assert: value equals: (memory long64At: 1).
			memory
				long64At: 10 put: 16r5555550000000000;
				long64At: 18 put: 16r0000005555555555.
			self assert: 16r5555555555555555 equals: (memory long64At: 15).
			"(1 to: 6) collect: [:i| (memory at: i) hex]"
			memory long64At: 13 put: value.
			self assert: value equals: (memory long64At: 13).
			self assert: 0 equals: (memory at: (shift <= 15 = (initial >= 0) ifTrue: [17] ifFalse: [13])).
			self assert: 0 equals: (memory at: (shift <= 15 = (initial >= 0) ifTrue: [21] ifFalse: [13]))]].
	63 to: 64 do:
		[:shift|
		self should: [memory long64At: 1 put: -1 << shift - 1] raise: Error.
		self should: [memory long64At: 1 put: 1 << shift] raise: Error].
	0 to: 63 do:
		[:shift| | value |
		value := 1 bitShift: shift.
		memory unsignedLong64At: 1 put: value.
		self assert: value equals: (memory unsignedLong64At: 1).
			memory
				unsignedLong64At: 10 put: 16r5555550000000000;
				unsignedLong64At: 18 put: 16r0000005555555555.
			self assert: 16r5555555555555555 equals: (memory unsignedLong64At: 15).
		memory unsignedLong64At: 7 put: value.
		self assert: value equals: (memory unsignedLong64At: 7).
		self assert: 0 equals: (memory at: (shift <= 31 ifTrue: [17] ifFalse: [9])).
		self assert: 0 equals: (memory at: (shift <= 31  ifTrue: [21] ifFalse: [13]))].
	self should: [memory unsignedLong64At: 1 put: -1] raise: Error.
	64 to: 65 do:
		[:shift|
		self should: [memory unsignedLong64At: 1 put: 1 << shift] raise: Error]