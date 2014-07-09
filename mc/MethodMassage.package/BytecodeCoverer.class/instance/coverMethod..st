covering
coverMethod: aMethod
	| labels basicBlockStarts unusedBytecode |
	self checkUnusedBytecodeSendsEnabled.
	labels := (BasicBlockLabellingDisassembler new disassemble: aMethod) labels.
	basicBlockStarts := Dictionary new.
	unusedBytecode := aMethod encoderClass unusedBytecode.
	self assert: unusedBytecode notNil.
	labels do:
		[:assoc| | pc |
		pc := assoc value.
		basicBlockStarts at: pc put: (aMethod at: pc).
		aMethod at: pc put: unusedBytecode].
	aMethod
		propertyValueAt: #coverage put: basicBlockStarts;
		voidCogVMState