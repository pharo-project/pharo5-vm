accessing
primJumpBufSize
	<export: true>
	
	interpreterProxy pop: interpreterProxy methodArgumentCount + 1 thenPush: 
		(interpreterProxy positive32BitIntegerFor:  (self sizeof: #jmp_buf asSymbol)).
	