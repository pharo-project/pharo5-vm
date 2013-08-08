instance creation
pc: pc nextpc: nextpc address: address type: type
	^self new
		pc: pc;
		nextpc: nextpc;
		address: address;
		type: type