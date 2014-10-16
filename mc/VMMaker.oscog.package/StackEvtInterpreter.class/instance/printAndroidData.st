process primitive support
printAndroidData
	<inline: true>
	self printAndroidString: 'instructionPointer:   '.
	self printAndroidUNum: (self pointerForOop: instructionPointer).
	self androidFlush. 
	self printAndroidString: 'stackPointer:   '.
	self printAndroidUNum: (self pointerForOop: stackPointer).
	self androidFlush. 
	self printAndroidString: 'framePointer:  '.
	self printAndroidUNum: (self pointerForOop: framePointer).
	self androidFlush. 
	self printAndroidString: 'currentBytecode  '.
	self printAndroidUNum: (currentBytecode bitAnd: 255).
	self androidFlush. 
	