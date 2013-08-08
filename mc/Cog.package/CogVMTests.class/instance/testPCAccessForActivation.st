tests
testPCAccessForActivation
	"self new testPCAccessForActivation"
	| runningOnCogit theProcess block run pc executingMachineCode scanner blockCount |
	runningOnCogit := self runningOnCogit.
	run := true.
	theProcess := Processor activeProcess.
	"Fork a process that will sample the pc of the following recursive block."
	[(Delay forMilliseconds: 1) wait.
	 pc := theProcess suspendedContext pc.
	 executingMachineCode := theProcess suspendedContext xrayIsExecutingMachineCode.
	 run := false] forkAt: Processor userInterruptPriority.
	"The only suspension point in this block is on activation (assuming
	 ifTrue: is inlined) so its pc must be the first bytecode in the block."
	block := [run ifTrue: [block value]].
	block value.
	"Find the first bytecode of the second block in this method."
	blockCount := 0.
	(scanner := InstructionStream on: thisContext method)
		scanFor:
			[:b| blockCount = 2 or: [b == 143 and: [blockCount := blockCount + 1. false]]].
	self assert: pc = scanner pc.
	self assert: executingMachineCode = runningOnCogit.
	"Fork a process that will use recurse: to infinitely recurse.
	 The only suspension point in this call is on activation (assuming
	 ifTrue: is inlined) so its pc must be the first bytecode in the method."
	theProcess := [self recurse] forkAt: Processor activePriority - 1.
	(Delay forMilliseconds: 1) wait.
	pc := theProcess suspendedContext pc.
	executingMachineCode := theProcess suspendedContext xrayIsExecutingMachineCode.
	theProcess terminate.
	self assert: pc = (self class compiledMethodAt: #recurse) initialPC.
	self assert: executingMachineCode = runningOnCogit