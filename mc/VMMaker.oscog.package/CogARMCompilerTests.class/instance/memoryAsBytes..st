private
memoryAsBytes: aByteArrayOrArray
	"Manage the fact that in the simulator inst machineCode object is an Array and the disassembler requires a ByteArray or some such."
	| bytes |
	aByteArrayOrArray isArray ifFalse:
		[^aByteArrayOrArray].
	bytes := ByteArray new: aByteArrayOrArray size * 4.
	1 to: aByteArrayOrArray size do:
		[:i|
		(aByteArrayOrArray at: i) ifNotNil:
			[:word|
			bytes unsignedLongAt: i - 1* 4 + 1 put: word]].
	^bytes