primitives
primitiveSetX11Input
	<export: true>
	<var: #d type: 'size_t'>
	| sema d |
	
	d := interpreterProxy stackPositiveMachineIntegerValue: 0.
	sema := interpreterProxy stackIntegerValue: 1.
	
	self setInputSemaphoreIndex: sema CurrentDisplay: d.
	
	interpreterProxy failed ifFalse: [  
		interpreterProxy pop: 2 ]