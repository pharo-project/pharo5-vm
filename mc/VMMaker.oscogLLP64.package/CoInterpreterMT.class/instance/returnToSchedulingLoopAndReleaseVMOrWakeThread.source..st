process primitive support
returnToSchedulingLoopAndReleaseVMOrWakeThread: vmThread source: source
	| savedReenterInterpreter |
	<var: #savedReenterInterpreter type: #'jmp_buf'>
	<var: #vmThread type: #'CogVMThread *'>
	<inline: false>
	self cCode:
			[self flag: 'this is just for debugging.  Note the current C stack pointers'.
			 cogThreadManager currentVMThread
				cStackPointer: cogit getCStackPointer;
				cFramePointer: cogit getCFramePointer]
		inSmalltalk:
			[| range |
			 range := self cStackRangeForThreadIndex: cogThreadManager getVMOwner.
			 self assert: (range includes: cogit getCStackPointer).
			 self assert: (range includes: cogit getCFramePointer)].
	"We must use a copy of reenterInterpreter since we're giving up the VM to another vmThread."
	self cCode:
			[self mem: savedReenterInterpreter asVoidPointer
				cp: reenterInterpreter
				y: (self sizeof: #'jmp_buf')]
		inSmalltalk:
			[savedReenterInterpreter := reenterInterpreter].
	self recordThreadSwitchTo: (vmThread ifNotNil: [vmThread index] ifNil: [0]) source: source.
	vmThread
		ifNotNil: [cogThreadManager wakeVMThreadFor: vmThread index]
		ifNil: [cogThreadManager releaseVM].
	"2 implies returning to the threadSchedulingLoop."
	self siglong: savedReenterInterpreter jmp: ReturnToThreadSchedulingLoop