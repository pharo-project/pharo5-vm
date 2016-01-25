execution
testGenerateInto: generateBlock disassembly: expectedDisassembly run: executeBlock
	| actualDisassembly compiler memory stopInstr instructions simulator |	
	MIPSConstants initialize.
	compiler := CogMIPSELCompiler new.
	
	stopInstr := compiler stop.
	memory := ByteArray new: 1024.
	1 to: 1024 by: 4 do:
		[:i | memory unsignedLongAt: i put: stopInstr bigEndian: false].

	instructions := Array streamContents: [:stream | generateBlock value: stream value: compiler].
	instructions withIndexDo: 
		[:instr :i | memory unsignedLongAt: (4 * (i - 1)) + 1 put: instr bigEndian: false].
	
	actualDisassembly := MIPSDisassembler new disassemble: memory from: 0 to: instructions size * 4.
	self assert: actualDisassembly equals: expectedDisassembly.
	
	simulator := MIPSELSimulator new initializeWithMemory: memory.
	executeBlock value: simulator.