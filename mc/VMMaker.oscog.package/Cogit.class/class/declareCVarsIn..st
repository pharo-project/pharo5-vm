translation
declareCVarsIn: aCCodeGenerator
	#(	'coInterpreter' 'objectMemory' 'methodZone' 'objectRepresentation'
		'cogBlockMethodSurrogateClass' 'cogMethodSurrogateClass'
		'threadManager' 'processor' 'lastNInstructions' 'simulatedAddresses'
		'simulatedTrampolines' 'simulatedVariableGetters' 'simulatedVariableSetters'
		'printRegisters' 'printInstructions' 'clickConfirm' 'singleStep') do:
			[:simulationVariableNotNeededForRealVM|
			aCCodeGenerator removeVariable: simulationVariableNotNeededForRealVM].
	NewspeakVM ifFalse:
		[#(	'dynSuperEntry' 'dynSuperEntryAlignment' 'dynamicSuperSendTrampolines'
			'ceImplicitReceiverTrampoline' 'ceExplicitReceiverTrampoline' 'cmDynSuperEntryOffset') do:
				[:variableNotNeededInNormalVM|
				aCCodeGenerator removeVariable: variableNotNeededInNormalVM]].
	aCCodeGenerator removeConstant: #COGMTVM. "this should be defined at compile time"
	aCCodeGenerator
		addHeaderFile:'<stddef.h>'; "for e.g. offsetof"
		addHeaderFile:'<setjmp.h>';
		addHeaderFile:'"sqCogStackAlignment.h"';
		addHeaderFile:'"cogmethod.h"';
		addHeaderFile:'#if COGMTVM';
		addHeaderFile:'"cointerpmt.h"';
		addHeaderFile:'#else';
		addHeaderFile:'"cointerp.h"';
		addHeaderFile:'#endif';
		addHeaderFile:'"cogit.h"';
		addHeaderFile:'"dispdbg.h"'.
	aCCodeGenerator
		var: #ceGetSP
			declareC: 'unsigned long (*ceGetSP)(void)';
		var: #ceCaptureCStackPointers
			declareC: 'void (*ceCaptureCStackPointers)(void)';
		var: #ceEnterCogCodePopReceiverReg
			declareC: 'void (*ceEnterCogCodePopReceiverReg)(void)';
		var: #realCEEnterCogCodePopReceiverReg
			declareC: 'void (*realCEEnterCogCodePopReceiverReg)(void)';
		var: #ceEnterCogCodePopReceiverAndClassRegs
			declareC: 'void (*ceEnterCogCodePopReceiverAndClassRegs)(void)';
		var: #realCEEnterCogCodePopReceiverAndClassRegs
			declareC: 'void (*realCEEnterCogCodePopReceiverAndClassRegs)(void)';
		var: #ceFlushICache
			declareC: 'static void (*ceFlushICache)(unsigned long from, unsigned long to)';
		var: #ceCheckFeaturesFunction
			declareC: 'static unsigned long (*ceCheckFeaturesFunction)(void)';
		var: #ceTryLockVMOwner
			declareC: 'unsigned long (*ceTryLockVMOwner)(void)';
		var: #ceUnlockVMOwner
			declareC: 'void (*ceUnlockVMOwner)(void)';
		var: #postCompileHook
			declareC: 'void (*postCompileHook)(CogMethod *, void *)';
		var: #openPICList declareC: 'CogMethod *openPICList = 0';
		var: #maxMethodBefore type: #'CogBlockMethod *'.
	aCCodeGenerator
		declareVar: 'aMethodLabel' type: #'AbstractInstruction'; "Has to come lexicographically before backEnd & methodLabel"
		var: #backEnd declareC: 'AbstractInstruction * const backEnd = &aMethodLabel';
		var: #methodLabel declareC: 'AbstractInstruction * const methodLabel = &aMethodLabel';
		var: #primInvokeLabel type: #'AbstractInstruction *'.
	self declareC: #(abstractOpcodes stackCheckLabel
					blockEntryLabel blockEntryNoContextSwitch
					stackOverflowCall sendMiss sendMissCall entry noCheckEntry dynSuperEntry
					mnuCall interpretCall interpretLabel endCPICCase0 endCPICCase1)
			as: #'AbstractInstruction *'
				in: aCCodeGenerator.
	aCCodeGenerator
		declareVar: #annotations type: #'InstructionAnnotation *';
		declareVar: #blockStarts type: #'BlockStart *';
		declareVar: #fixups type: #'BytecodeFixup *'.
	aCCodeGenerator
		var: #sendTrampolines
			declareC: 'sqInt sendTrampolines[NumSendTrampolines]';
		var: #superSendTrampolines
			declareC: 'sqInt superSendTrampolines[NumSendTrampolines]';
		var: #dynamicSuperSendTrampolines
			declareC: 'sqInt dynamicSuperSendTrampolines[NumSendTrampolines]';
		var: #trampolineAddresses
			declareC: 'static char *trampolineAddresses[NumTrampolines*2]';
		var: #objectReferencesInRuntime
			declareC: 'static sqInt objectReferencesInRuntime[NumObjRefsInRuntime]';
		var: #labelCounter
			type: #int;
		var: #traceFlags
			declareC: 'int traceFlags = 8 /* prim trace log on by default */';
		var: #cStackAlignment
			declareC: 'const int cStackAlignment = STACK_ALIGN_BYTES'.
	aCCodeGenerator
		declareVar: #CFramePointer type: #'void *';
		declareVar: #CStackPointer type: #'void *';
		declareVar: #minValidCallAddress type: #'unsigned long';
		declareVar: #debugPrimCallStackOffset type: #'unsigned long'.
	aCCodeGenerator vmClass generatorTable ifNotNil:
		[:bytecodeGenTable|
		aCCodeGenerator
			var: #generatorTable
				declareC: 'BytecodeDescriptor generatorTable[', bytecodeGenTable size printString, ']',
							(self tableInitializerFor: bytecodeGenTable
								in: aCCodeGenerator);
			var: #primitiveGeneratorTable
				declareC: 'PrimitiveDescriptor primitiveGeneratorTable[MaxCompiledPrimitiveIndex+1]',
							(self tableInitializerFor: aCCodeGenerator vmClass primitiveTable
								in: aCCodeGenerator)].
	"In C the abstract opcode names clash with the Smalltak generator syntactic sugar.
	 Most of the syntactic sugar is inlined, but alas some remains.  Rename the syntactic
	 sugar to avoid the clash."
	(self organization listAtCategoryNamed: #'abstract instructions') do:
		[:s|
		aCCodeGenerator addSelectorTranslation: s to: 'g', (aCCodeGenerator cFunctionNameFor: s)].
	aCCodeGenerator addSelectorTranslation: #halt: to: 'haltmsg'