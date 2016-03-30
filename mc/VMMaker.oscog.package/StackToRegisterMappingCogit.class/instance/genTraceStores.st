bytecode generator support
genTraceStores
	<inline: true>
	traceStores > 0 ifTrue: 
		[ self MoveR: ClassReg R: TempReg.
		self CallRT: ceTraceStoreTrampoline ].