marshalling
ffiPushStructure: pointer ofSize: structSize typeSpec: argSpec ofLength: argSpecSize in: calloutState
	<var: #pointer type: #'void *'>
	<var: #argSpec type: #'sqInt *'>
	<var: #calloutState type: #'CalloutState *'>
	<inline: true>
	| roundedSize doubleType floatType numDoubleRegisters numIntegerRegisters passField0InXmmReg passField1InXmmReg |
	structSize <= 16 ifTrue:
		["See sec 3.2.3 of http://people.freebsd.org/~obrien/amd64-elf-abi.pdf. (dravft version 0.90).
		  All of the folowing are passed in registers:
			typedef struct { long a; } s0;
			typedef struct { double a; } s1;
			typedef struct { long a; double b; } s2;
			typedef struct { int a; int b; double c; } s2a;
			typedef struct { short a; short b; short c; short d; double e; } s2b;
			typedef struct { long a; float b; } s2f;
			typedef struct { long a; float b; float c; } s2g;
		  but not ones like this:
			typedef struct { int a; float b; int c; float d; } s2h;"
		 doubleType := FFITypeDoubleFloat << FFIAtomicTypeShift + FFITypeDoubleFloat.
		 floatType := FFITypeDoubleFloat << FFIAtomicTypeShift + FFITypeSingleFloat.
		 passField0InXmmReg := doubleType = ((self cCoerce: argSpec to: #'int *') at: 1) "0th field is struct type and size"
								or: [floatType = ((self cCoerce: argSpec to: #'int *') at: 1)
									and: [floatType = ((self cCoerce: argSpec to: #'int *') at: 2)]].
		 structSize <= 8
			ifTrue:
				[numDoubleRegisters := passField0InXmmReg ifTrue: [1] ifFalse: [0].
				 numIntegerRegisters := 1 - numDoubleRegisters]
			ifFalse:
				[passField1InXmmReg := doubleType = ((self cCoerce: argSpec to: #'int *') at: argSpecSize - 1) "Nth field is last field of struct"
										or: [floatType = ((self cCoerce: argSpec to: #'int *') at: argSpecSize - 2)
											and: [floatType = ((self cCoerce: argSpec to: #'int *') at: argSpecSize - 1)]].
				 numDoubleRegisters := (passField0InXmmReg ifTrue: [1] ifFalse: [0]) + (passField1InXmmReg ifTrue: [1] ifFalse: [0]).
				 numIntegerRegisters := 2 - numDoubleRegisters].
		 (calloutState floatRegisterIndex + numDoubleRegisters <= NumFloatRegArgs
		  and: [calloutState integerRegisterIndex + numIntegerRegisters <= NumIntRegArgs]) ifTrue:
			[passField0InXmmReg
				ifTrue: [self ffiPushDoubleFloat: ((self cCoerceSimple: pointer to: #'double *') at: 0) in: calloutState]
				ifFalse: [self ffiPushSignedLongLong: ((self cCoerceSimple: pointer to: #'long long *') at: 0) in: calloutState].
			 structSize > 8 ifTrue:
				[passField1InXmmReg
					ifTrue: [self ffiPushDoubleFloat: ((self cCoerceSimple: pointer to: #'double *') at: 1) in: calloutState]
					ifFalse: [self ffiPushSignedLongLong: ((self cCoerceSimple: pointer to: #'long long *') at: 1) in: calloutState]].
			 ^0].

	roundedSize := structSize + 7 bitClear: 7.
	calloutState currentArg + roundedSize > calloutState limit ifTrue:
		 [^FFIErrorCallFrameTooBig].
	self mem: calloutState currentArg cp: (self cCoerceSimple: pointer to: 'char *') y: structSize.
	calloutState currentArg: calloutState currentArg + roundedSize].
	^0