marshalling
ffiPushStructure: pointer ofSize: structSize typeSpec: argSpec ofLength: argSpecSize in: calloutState
	<var: #pointer type: #'void *'>
	<var: #argSpec type: #'sqInt *'>
	<var: #calloutState type: #'CalloutState *'>
	<inline: true>
	| availableRegisterSpace stackPartSize roundedSize |

	availableRegisterSpace := (NumIntRegArgs - calloutState integerRegisterIndex) * 4.
	stackPartSize := structSize.
	availableRegisterSpace > 0
		ifTrue: 
			[structSize <= availableRegisterSpace
				ifTrue:
					["all in registers"
					 stackPartSize := 0.
					 self 
						mem: (self cCoerceSimple: (self addressOf: (calloutState integerRegisters at: calloutState integerRegisterIndex)) to: 'void *') 
						cp: pointer 
						y: structSize.
					 calloutState integerRegisterIndex: calloutState integerRegisterIndex + (structSize + 3 bitShift: -2) ]
				ifFalse:
					["If no previous co-processor candidate arg has already been pushed on the stack, then split the struct between registers and stack.
					  Otherwise push entire struct on stack."
					 calloutState currentArg = calloutState argVector
						ifTrue: 
					 		[stackPartSize := structSize - availableRegisterSpace.
					 		self 
								mem: (self cCoerceSimple: (self addressOf: (calloutState integerRegisters at: calloutState integerRegisterIndex)) to: 'void *') 
								cp: pointer 
								y: availableRegisterSpace]
						ifFalse:
							[availableRegisterSpace := 0].
					calloutState integerRegisterIndex: NumIntRegArgs]].

	stackPartSize > 0
		ifTrue: 
			[roundedSize := stackPartSize + 3 bitClear: 3.
			 calloutState currentArg + roundedSize > calloutState limit ifTrue:
				 [^FFIErrorCallFrameTooBig].
			 self mem: calloutState currentArg cp: (self addressOf: ((self cCoerceSimple: pointer to: 'char *') at: availableRegisterSpace)) y: stackPartSize.
			 calloutState currentArg: calloutState currentArg + roundedSize].
	^0