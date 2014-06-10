accessing
memory 
"build a memory for this test; a ByteArray of 1024 bytes, filled with NOPs"
	| mem |
	mem := ByteArray new: 1024.
	1 to: 1024  by: 4do:[:i|
		mem unsignedLongAt: i put: 16rE1A00000 bigEndian: false].
	^mem