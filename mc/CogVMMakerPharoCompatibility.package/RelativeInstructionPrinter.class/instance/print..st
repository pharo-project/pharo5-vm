printing
print: instruction 
	"Append to the receiver a description of the bytecode, instruction." 

	stream tab: self indent.
	labelling
		ifTrue: [stream print: oldPC - method initialPC; space]
		ifFalse: [stream tab].
	stream tab: (innerIndents at: oldPC).
	self printCode ifTrue:
		[stream nextPut: $<.
		 oldPC to: scanner pc - 1 do: 
			[:i | | code |
			code := (method at: i) radix: 16.
			stream
				nextPut: (code size < 2 ifTrue: [$0] ifFalse: [code at: 1]);
				nextPut: code last;
				space].
		 stream skip: -1; nextPut: $>; space].
	stream nextPutAll: instruction.
	stream cr.
	labelling ifFalse:
		[(labels at: scanner pc + 1) ~~ false ifTrue:
			[stream nextPutAll: (labels at: scanner pc + 1); nextPut: $:; cr]].
	oldPC := scanner pc