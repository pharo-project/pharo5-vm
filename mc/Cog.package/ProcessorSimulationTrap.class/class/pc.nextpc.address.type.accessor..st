instance creation
pc: pc nextpc: nextpc address: address type: type accessor: regAccessorMessage
	^self new
		pc: pc;
		nextpc: nextpc;
		address: address;
		type: type;
		registerAccessor: regAccessorMessage