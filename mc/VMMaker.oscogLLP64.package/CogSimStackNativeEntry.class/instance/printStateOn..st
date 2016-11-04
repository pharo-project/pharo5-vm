printing
printStateOn: aStream
	<doNotGenerate> "Smalltalk-side only"
	type isInteger ifFalse: [^self].
	aStream nextPut: $(.
	type caseOf: {
		[SSNativeRegister]	-> [aStream
								nextPutAll: 'reg ';
								nextPutAll: (CogRTLOpcodes nameForRegister: register)].
		[SSRegisterPair]	-> [aStream
								nextPutAll: 'reg ';
								nextPutAll: (CogRTLOpcodes nameForRegister: register);
								nextPutAll: '+';
								nextPutAll: (CogRTLOpcodes nameForRegister: registerSecond).].
		[SSRegisterSingleFloat]	-> [aStream
								nextPutAll: 'regFloat32 ';
								nextPutAll: (CogRTLOpcodes nameForRegister: register)].
		[SSRegisterDoubleFloat]	-> [aStream
								nextPutAll: 'regFloat64 ';
								nextPutAll: (CogRTLOpcodes nameForRegister: register)].

		[SSSpillNative]		-> [aStream
								nextPutAll: 'spillNative @ '.
							offset negative ifFalse: [aStream nextPut: $+].
							aStream print: offset].
		[SSSpillInt64]		-> [aStream
								nextPutAll: 'spillInt64 @ '.
							offset negative ifFalse: [aStream nextPut: $+].
							aStream print: offset].
		[SSSpillFloat32]		-> [aStream
								nextPutAll: 'spillFloat32 @ '.
							offset negative ifFalse: [aStream nextPut: $+].
							aStream print: offset].
		[SSSpillFloat64]		-> [aStream
								nextPutAll: 'spillFloat64 @ '.
							offset negative ifFalse: [aStream nextPut: $+].
							aStream print: offset].

		[SSConstantInt32]		-> [aStream
								nextPutAll: 'constInt32 ';
								print: constantInt32].
		[SSConstantInt64]		-> [aStream
								nextPutAll: 'constInt64 ';
								print: constantInt64].
		[SSConstantFloat32]		-> [aStream
								nextPutAll: 'constFloat32 ';
								print: constantFloat32].
		[SSConstantFloat64]		-> [aStream
								nextPutAll: 'constFloat64 ';
								print: constantFloat64].
		[SSConstantNativePointer]	-> [aStream
								nextPutAll: 'constNativePointer ';
								print: constantNativePointer]
 }.
	spilled ifTrue:
		[aStream nextPutAll: ' (spilled)'].
	bcptr ifNotNil:
		[aStream space; nextPut: ${; print: bcptr; nextPut: $}].
	aStream nextPut: $)