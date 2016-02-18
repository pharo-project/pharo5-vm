external primitive support
rewritePrimInvocationIn: cogMethod to: primFunctionPointer
	<api>
	<var: #cogMethod type: #'CogMethod *'>
	<var: #primFunctionPointer declareC: #'void (*primFunctionPointer)(void)'>
	| primIndex flags address extent |
	self assert: cogMethod cmType = CMMethod.
	primIndex := coInterpreter
					primitiveIndexOfMethod: cogMethod methodObject
					header: cogMethod methodHeader.
	flags := coInterpreter primitivePropertyFlags: primIndex.
	(flags anyMask: PrimCallNeedsPrimitiveFunction) ifTrue:
		[backEnd
			storeLiteral: primFunctionPointer asUnsignedInteger
			beforeFollowingAddress: cogMethod asUnsignedInteger
									+ (externalSetPrimOffsets at: cogMethod cmNumArgs)].
	"See compileInterpreterPrimitive:"
	(flags anyMask: PrimCallMayCallBack)
		ifTrue:
			[address := cogMethod asUnsignedInteger
						+ (externalPrimJumpOffsets at: cogMethod cmNumArgs).
			extent := backEnd
						rewriteJumpFullAt: address
						target: (self cCode: [primFunctionPointer asUnsignedInteger]
									inSmalltalk: [self simulatedTrampolineFor: primFunctionPointer])]
		ifFalse:
			[address := cogMethod asUnsignedInteger
						+ (externalPrimCallOffsets at: cogMethod cmNumArgs).
			extent := backEnd
						rewriteCallFullAt: address
						target: (self cCode: [primFunctionPointer asUnsignedInteger]
									inSmalltalk: [self simulatedTrampolineFor: primFunctionPointer])].
	processor
		flushICacheFrom: cogMethod asUnsignedInteger + cmNoCheckEntryOffset
		to: address asUnsignedInteger + extent