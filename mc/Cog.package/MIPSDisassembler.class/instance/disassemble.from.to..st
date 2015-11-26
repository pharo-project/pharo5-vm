as yet unclassified
disassemble: memory from: startPC to: limitPC
	| stream |
	stream := WriteStream on: ''.
	self disassemble: memory from: startPC to: limitPC for: nil labels: nil on: stream.
	^stream contents