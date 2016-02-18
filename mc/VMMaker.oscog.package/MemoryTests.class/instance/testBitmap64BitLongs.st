testing
testBitmap64BitLongs
	"Test that Bitmap provides big-endian access for 64-bit accessors"
	| memory |
	memory := Bitmap new: 64.
	0 to: 62 do:
		[:shift|
		#(-1 1) do:
			[:initial| | value |
			memory atAllPut: 0.
			value := initial bitShift: shift.
			memory long64At: 1 put: value.
			self assert: value equals: (memory long64At: 1).
			memory
				long64At: 10 put: 16r0000000000555555;
				long64At: 18 put: 16r5555555555000000.
			self assert: 16r5555555555555555 equals: (memory long64At: 15).
			"(1 to: 7) collect: [:i| (memory at: i) hex]"
			memory long64At: 13 put: value.
			self assert: value equals: (memory long64At: 13).
			self assert: 0 equals: (memory at: (shift <= 15 = (initial >= 0) ifTrue: [9] ifFalse: [17])).
			self assert: 0 equals: (memory at: (shift <= 15 = (initial >= 0) ifTrue: [13] ifFalse: [21]))]].
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
				unsignedLong64At: 10 put: 16r0000000000555555;
				unsignedLong64At: 18 put: 16r5555555555000000.
			self assert: 16r5555555555555555 equals: (memory unsignedLong64At: 15).
		memory unsignedLong64At: 7 put: value.
		self assert: value equals: (memory unsignedLong64At: 7).
		self assert: 0 equals: (memory at: (shift <= 31 ifTrue: [9] ifFalse: [17])).
		self assert: 0 equals: (memory at: (shift <= 31  ifTrue: [13] ifFalse: [21]))].
	self should: [memory unsignedLong64At: 1 put: -1] raise: Error.
	64 to: 65 do:
		[:shift|
		self should: [memory unsignedLong64At: 1 put: 1 << shift] raise: Error]