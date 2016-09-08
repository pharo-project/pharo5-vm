generate machine code
fillInCounters: nCounters atStartAddress: startAddress
	startAddress
		to: startAddress + (nCounters - 1 * CounterBytes)
		by: CounterBytes
		do: [:address|
			objectMemory
				long32At: address
				put: (initialCounterValue << 16 + initialCounterValue)]