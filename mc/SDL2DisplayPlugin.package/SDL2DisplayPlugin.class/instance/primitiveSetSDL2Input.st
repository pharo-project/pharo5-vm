primitives
primitiveSetSDL2Input
	<export: true>
	| sema |
	
	sema := interpreterProxy stackIntegerValue: 0.
	
	self setSDL2InputSemaphoreIndex: sema.
	
	interpreterProxy failed ifFalse: [  
		interpreterProxy pop: 1 ]