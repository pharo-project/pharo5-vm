bytecode generator support
genLoadTemp: objectIndex in: destReg
	destReg = ReceiverResultReg ifTrue: [self voidReceiverResultRegContainsSelf].
	self ssAllocateRequiredReg: destReg. 
	self MoveMw: (self frameOffsetOfTemporary: objectIndex) r: FPReg R: destReg.