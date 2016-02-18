printing
print: instruction 
	"Append to the receiver a description of the bytecode, instruction." 

	| code |
	stream tab: self indent.
	printPC ifTrue: [stream print: oldPC; space].
	stream tab: (innerIndents at: oldPC).
	stream nextPut: $<.
	oldPC to: scanner pc - 1 do: 
		[:i | 
		code := (method at: i) radix: 16.
		stream nextPut: 
			(code size < 2
				ifTrue: [$0]
				ifFalse: [code at: 1]).
		stream nextPut: code last; space].
	stream skip: -1.
	stream nextPut: $>.
	stream space.
	stream nextPutAll: instruction.
	stream cr.
	oldPC := scanner pc.
	"(InstructionPrinter compiledMethodAt: #print:) symbolic."
