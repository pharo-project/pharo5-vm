method map
printMcpc: mcpc Bcpc: bcpc on: aStream
	<doNotGenerate>
	aStream ensureCr.
	mcpc printOn: aStream base: 16.
	aStream space; tab; print: bcpc; cr; flush.
	^0