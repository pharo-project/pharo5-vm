accessing
memory 
"build a memory for this test; a ByteArray of 1024 bytes, filled with NOPs"
	| mem nop|
	nop := CogARMCompiler new mov: 0  rn: 0.
	mem := ByteArray new: 1024.
	1 to: 1024  by: 4do:[:i|
		mem unsignedLongAt: i put: nop bigEndian: false].
	^mem