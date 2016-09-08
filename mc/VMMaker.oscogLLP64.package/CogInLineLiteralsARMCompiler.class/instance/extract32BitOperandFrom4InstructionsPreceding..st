testing
extract32BitOperandFrom4InstructionsPreceding: addr
	<inline: true>
	^(objectMemory byteAt: addr -4) 
	 + ((objectMemory byteAt: addr - 8) << 8) 
	 + ((objectMemory byteAt: addr - 12) << 16) 
	 + ((objectMemory byteAt: addr - 16) << 24)