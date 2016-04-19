printing
printStateOn: aStream
	<doNotGenerate> "Smalltalk-side only"
	type isInteger ifFalse: [^self].
	aStream nextPut: $(.
	type caseOf: {
		[SSBaseOffset]	-> [aStream
								nextPutAll: 'bo ';
								nextPutAll: (cogit backEnd nameForRegister: register).
							offset negative ifFalse: [aStream nextPut: $+].
							aStream print: offset].
		[SSConstant]	-> [aStream
								nextPutAll: 'const ';
								print: constant].
		[SSRegister]	-> [aStream
								nextPutAll: 'reg ';
								nextPutAll: (cogit backEnd nameForRegister: register)].
		[SSSpill]		-> [aStream
								nextPutAll: 'spill @ ';
								nextPutAll: (cogit backEnd nameForRegister: register).
							offset negative ifFalse: [aStream nextPut: $+].
							aStream print: offset] }.
	(spilled and: [type ~= SSSpill]) ifTrue:
		[aStream nextPutAll: ' (spilled)'].
	bcptr ifNotNil:
		[aStream space; nextPut: ${; print: bcptr; nextPut: $}].
	aStream nextPut: $)