bytecode generator support
genTraceStores
	<inline: true>
	traceStores > 0 ifTrue: [ self CallRT: ceTraceStoreTrampoline ].