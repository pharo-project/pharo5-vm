bytecode generator support
genLoadTemp: objectIndex in: destReg
	destReg = ReceiverResultReg ifTrue: [ optStatus isReceiverResultRegLive: false ].
	self ssAllocateRequiredReg: destReg. 
	self MoveMw: (self frameOffsetOfTemporary: objectIndex) r: FPReg R: destReg.