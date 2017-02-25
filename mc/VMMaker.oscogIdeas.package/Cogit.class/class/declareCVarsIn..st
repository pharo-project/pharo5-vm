translation
declareCVarsIn: aCCodeGenerator
	#(	'coInterpreter' 'objectMemory' 'methodZone' 'objectRepresentation'
		'cogBlockMethodSurrogateClass' 'cogMethodSurrogateClass' 'nsSendCacheSurrogateClass'
		'threadManager' 'processor' 'lastNInstructions' 'simulatedAddresses'
		'simulatedTrampolines' 'simulatedVariableGetters' 'simulatedVariableSetters'
		'printRegisters' 'printInstructions' 'clickConfirm' 'singleStep') do:
			[:simulationVariableNotNeededForRealVM|
			aCCodeGenerator removeVariable: simulationVariableNotNeededForRealVM].
	NewspeakVM ifFalse:
		[#(	'selfSendTrampolines' 'dynamicSuperSendTrampolines'
			'implicitReceiverSendTrampolines' 'outerSendTrampolines'
			'ceEnclosingObjectTrampoline' 'numIRCs' 'indexOfIRC' 'theIRCs') do:
				[:variableNotNeededInNormalVM|
				aCCodeGenerator removeVariable: variableNotNeededInNormalVM]].
	aCCodeGenerator removeConstant: #COGMTVM. "this should be defined at compile time"
	aCCodeGenerator
		addHeaderFile:'<stddef.h>'; "for e.g. offsetof"
		addHeaderFile:'"sqCogStackAlignment.h"';
		addHeaderFile:'"dispdbg.h"'; "must precede cointerp.h & cogit.h otherwise NoDbgRegParms gets screwed up"
		addHeaderFile:'"cogmethod.h"'.
	NewspeakVM ifTrue:
		[aCCodeGenerator addHeaderFile:'"nssendcache.h"'].
	aCCodeGenerator
		addHeaderFile:'#if COGMTVM';
		addHeaderFile:'"cointerpmt.h"';
		addHeaderFile:'#else';
		addHeaderFile:'"cointerp.h"';
		addHeaderFile:'#endif';
		addHeaderFile:'"cogit.h"'.
	aCCodeGenerator
		var: #ceGetFP
			declareC: 'usqIntptr_t (*ceGetFP)(void)';
		var: #ceGetSP
			declareC: 'usqIntptr_t (*ceGetSP)(void)';
		var: #ceCaptureCStackPointers
			declareC: 'void (*ceCaptureCStackPointers)(void)';
		var: #ceEnterCogCodePopReceiverReg
			declareC: 'void (*ceEnterCogCodePopReceiverReg)(void)';
		var: #realCEEnterCogCodePopReceiverReg
			declareC: 'void (*realCEEnterCogCodePopReceiverReg)(void)';
		var: #ceCallCogCodePopReceiverReg
			declareC: 'void (*ceCallCogCodePopReceiverReg)(void)';
		var: #realCECallCogCodePopReceiverReg
			declareC: 'void (*realCECallCogCodePopReceiverReg)(void)';
		var: #ceCallCogCodePopReceiverAndClassRegs
			declareC: 'void (*ceCallCogCodePopReceiverAndClassRegs)(void)';
		var: #realCECallCogCodePopReceiverAndClassRegs
			declareC: 'void (*realCECallCogCodePopReceiverAndClassRegs)(void)';
		var: #ceFlushICache
			declareC: 'static void (*ceFlushICache)(usqIntptr_t from, usqIntptr_t to)';
		var: #ceCheckFeaturesFunction
			declareC: 'static usqIntptr_t (*ceCheckFeaturesFunction)(void)';
		var: #ceTryLockVMOwner
			declareC: 'usqIntptr_t (*ceTryLockVMOwner)(void)';
		var: #ceUnlockVMOwner
			declareC: 'void (*ceUnlockVMOwner)(void)';
		var: #postCompileHook
			declareC: 'void (*postCompileHook)(CogMethod *)';
		var: #openPICList declareC: 'CogMethod *openPICList = 0';
		var: #maxMethodBefore type: #'CogBlockMethod *';
		var: 'enumeratingCogMethod' type: #'CogMethod *'.
	aCCodeGenerator
		declareVar: 'aMethodLabel' type: #'AbstractInstruction'; "Has to come lexicographically before backEnd & methodLabel"
		var: #backEnd declareC: 'AbstractInstruction * const backEnd = &aMethodLabel';
		var: #methodLabel declareC: 'AbstractInstruction * const methodLabel = &aMethodLabel'.
	self declareC: #(abstractOpcodes stackCheckLabel
					blockEntryLabel blockEntryNoContextSwitch
					stackOverflowCall sendMiss
					entry noCheckEntry selfSendEntry dynSuperEntry
					fullBlockNoContextSwitchEntry fullBlockEntry
					picMNUAbort picInterpretAbort  endCPICCase0 endCPICCase1 cPICEndOfCodeLabel)
			as: #'AbstractInstruction *'
				in: aCCodeGenerator.
	aCCodeGenerator
		declareVar: #blockStarts type: #'BlockStart *';
		declareVar: #fixups type: #'BytecodeFixup *'.
	aCCodeGenerator
		var: #ordinarySendTrampolines
			declareC: 'sqInt ordinarySendTrampolines[NumSendTrampolines]';
		var: #superSendTrampolines
			declareC: 'sqInt superSendTrampolines[NumSendTrampolines]';
		var: #directedSuperSendTrampolines
			declareC: 'sqInt directedSuperSendTrampolines[NumSendTrampolines]';
		var: #selfSendTrampolines
			declareC: 'sqInt selfSendTrampolines[NumSendTrampolines]';
		var: #dynamicSuperSendTrampolines
			declareC: 'sqInt dynamicSuperSendTrampolines[NumSendTrampolines]';
		var: #implicitReceiverSendTrampolines
			declareC: 'sqInt implicitReceiverSendTrampolines[NumSendTrampolines]';
		var: #outerSendTrampolines
			declareC: 'sqInt outerSendTrampolines[NumSendTrampolines]';
		var: #trampolineAddresses
			declareC: 'static char *trampolineAddresses[NumTrampolines*2]';
		var: #objectReferencesInRuntime
			declareC: 'static usqInt objectReferencesInRuntime[NumObjRefsInRuntime]';
		var: #labelCounter
			type: #int;
		var: #traceFlags
			declareC: 'int traceFlags = 8 /* prim trace log on by default */';
		var: #cStackAlignment
			declareC: 'const int cStackAlignment = STACK_ALIGN_BYTES'.
	aCCodeGenerator
		declareVar: #CFramePointer type: #'void *';
		declareVar: #CStackPointer type: #'void *';
		declareVar: #minValidCallAddress type: #'usqIntptr_t';
		declareVar: #debugPrimCallStackOffset type: #'usqIntptr_t'.
	aCCodeGenerator vmClass generatorTable ifNotNil:
		[:bytecodeGenTable|
		aCCodeGenerator
			var: #generatorTable
				declareC: 'static BytecodeDescriptor generatorTable[', bytecodeGenTable size, ']',
							(self tableInitializerFor: bytecodeGenTable
								in: aCCodeGenerator)].
	"In C the abstract opcode names clash with the Smalltak generator syntactic sugar.
	 Most of the syntactic sugar is inlined, but alas some remains.  Rename the syntactic
	 sugar to avoid the clash."
	(self organization listAtCategoryNamed: #'abstract instructions') do:
		[:s|
		aCCodeGenerator addSelectorTranslation: s to: 'g', (aCCodeGenerator cFunctionNameFor: s)].
	aCCodeGenerator addSelectorTranslation: #halt: to: 'haltmsg'