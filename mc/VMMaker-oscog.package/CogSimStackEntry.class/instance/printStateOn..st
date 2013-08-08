printing
printStateOn: aStream
	<doNotGenerate> "Smalltalk-side only"
	type isInteger ifFalse: [^self].
	aStream nextPut: $(.
	type caseOf: {
		[SSBaseOffset]	-> [aStream
								nextPutAll: 'bo ';
								nextPutAll: (CogRTLOpcodes nameForRegister: register).
							offset negative ifFalse: [aStream nextPut: $+].
							aStream print: offset].
		[SSConstant]	-> [aStream
								nextPutAll: 'const ';
								print: constant].
		[SSRegister]	-> [aStream
								nextPutAll: 'reg ';
								nextPutAll: (CogRTLOpcodes nameForRegister: register)].
		[SSSpill]		-> [aStream
								nextPutAll: 'spill @ ';
								nextPutAll: (CogRTLOpcodes nameForRegister: register).
							offset negative ifFalse: [aStream nextPut: $+].
							aStream print: offset] }.
	(spilled and: [type ~= SSSpill]) ifTrue:
		[aStream nextPutAll: ' (spilled)'].
	annotateUse ifTrue:
		[aStream nextPutAll: ' (ANNOTATED)'].
	bcptr ifNotNil:
		[aStream space; nextPut: ${; print: bcptr; nextPut: $}].
	aStream nextPut: $)