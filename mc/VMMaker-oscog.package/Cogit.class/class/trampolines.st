documentation
trampolines
	"Trampolines are called from machine-code for a number of tasks (e.g. doing an unlinked send,
	 creating a closure, doing a non-local return, etc, etc.
	 Some trampolines save their return pc on the Smalltalk stack, and some pop it into instructionPointer,
	 depending on whether the trampoline always returns or whether control might transfer elsewhere,
	 or depending on whether the callee run-time routine expects to see a normal Smalltalk stack.  This
	 documents which trampolines do what and why.

ceSend0Args .. ceSendNArgs, ceSuperSend0Args..ceSuperSendNArgs
	return pc left on stack because it is the return pc of the send and must be there

ceMethodAbort, cePICAbort
	return pc left on stack because it is used to locate the failing send target method/PIC of a linked send

ceClosureCopyTrampoline
	return pc left on stack because ceClosureCopy:... always returns directly

cePushActiveContextTrampoline
	return pc left on stack because cePushActiveContext always returns directly

ceNonLocalReturnTrampoline
	pops return pc into instructionPointer

ceBaseFrameReturnTrampoline
	this is returned-to and never called; i.e. it is the return pc of a base machine-code frame

ceCreateNewArrayTrampoline
	return pc left on stack because ceNewArraySlotSize always returns directly

ceSendMustBeBooleanTrampoline
	return pc left on stack because it is the return pc of the send and must be there

ceCheckForInterruptsTrampoline
	pops return pc into instructionPointer

ceCPICMissTrampoline
	return pc left on stack because it is used to locate the failing send target PIC of a linked send

ceSendFromInLineCacheMissTrampoline
	not used, but its addres is used as a key in the simulator.  An open PIC calls ceSendFromInLineCacheMiss
	after it has switched from the Smalltalk to teh C stack (an inline trampoline) hence there is no return pc
	left on the Smalltalk stack (except that of the send that invoked the open PIC).

ceStoreCheckTrampoline
	return pc left on stack because ceStoreCheck always returns directly

ceFetchContextInstVarTrampoline
	return pc left on stack because ceContextInstVar always returns directly.
	ceContextInstVar manages popping the pc into instructionPointer if necessary.

ceStoreContextInstVarTrampoline
	return pc left on stack because ceContextInstVarvalue always returns directly.
	ceContextInstVarvalue manages popping the pc into instructionPointer if necessary.

cePositive32BitIntegerTrampoline
	return pc left on stack because cePositive32BitInteger always returns directly
	
ceReturnToInterpreterTrampoline
	this is returned-to and never called; i.e. it is the return pc of a machine-code frame with an interpreted callee

ceResendCannotReturnTrampoline
	this is returned-to and never called; it is the pc for a machine-code frame which has been returned from

ceEnterCogCodePopReceiverReg
	this is an enilopmart and not called from machine code

cePrimReturnEnterCogCode
	this is an enilopmart and not called from machine code

ceTraceLinkedSendTrampoline
	return pc left on stack because ceTraceLinkedSend always returns directly

ceTraceBlockActivationTrampoline
	return pc left on stack because ceTraceBlockActivation always returns directly

ceTraceStoreTrampoline
	return pc left on stack because ceTraceStore always returns directly"