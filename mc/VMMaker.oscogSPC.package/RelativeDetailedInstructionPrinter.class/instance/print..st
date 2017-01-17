printing
print: instruction
	| current next |
	super print: instruction.
	labelling ifFalse:
		[current := stackHeightComputer stackp.
		 stackHeightComputer interpretNextInstructionFor: stackHeightComputer.
		 next := stackHeightComputer stackp.
		 stream
			skip: -1;
			tab; tab; nextPut: $(;
			print: current.
		 current ~= next ifTrue:
			[stream nextPut: $-; nextPut: $>; print: next].
		 stream
			nextPut: $);
			cr;
			flush.
		 saveLabel isEmpty ifFalse:
			[stream nextPutAll: saveLabel; flush]]