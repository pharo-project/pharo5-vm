return bytecodes
returnToMachineCodeFrame
	"Return to the previous context/frame after assigning localIP, localSP and localFP."
	<inline: true>
	cogit assertCStackWellAligned.
	self assert: localIP asUnsignedInteger < objectMemory startOfMemory.
	self assert: (self isMachineCodeFrame: localFP).
	self assertValidExecutionPointe: localIP asUnsignedInteger r: localFP s: localSP imbar: false line: #'__LINE__'.
	self internalStackTopPut: localIP.
	self internalPush: localReturnValue.
	self externalizeFPandSP.
	self cCode: '' inSmalltalk:
		[self maybeCheckStackDepth: 1 sp: stackPointer pc: localIP].
	cogit ceEnterCogCodePopReceiverReg
	"NOTREACHED"