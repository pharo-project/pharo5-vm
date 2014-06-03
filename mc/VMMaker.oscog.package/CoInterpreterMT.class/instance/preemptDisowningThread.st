vm scheduling
preemptDisowningThread
	"Set the relevant state for disowningVMThread so that it can resume after
	 being preempted and set disowningVMThread to nil to indicate preemption.

	 N.B.  This should only be sent from checkPreemptionOfDisowningThread.

	 There are essentially four things to do.
	 a)	save the VM's notion of the current C stack pointers; these are pointers
		into a thread's stack and must be saved and restored in thread switch.
	 b)	save the VM's notion of the current Smalltalk execution point.  This is
		simply the suspend half of a process switch that saves the current context
		in the current process.
	 c)	add the process to the thread's set of AWOL processes so that the scheduler
		won't try to run the process while the thread has disowned the VM.
	 d)	save the in-primitive VM state, newMethod and argumentCount

	 ownVM: will restore the VM context as of disownVM: from the above when it
	 finds it has been preempted."

	| activeProc activeContext preemptedThread |
	<var: #preemptedThread type: #'CogVMThread *'>
	<inline: false>
	self assert: disowningVMThread notNil.
	self assert: (disowningVMThread state = CTMUnavailable
				or: [disowningVMThread state = CTMWantingOwnership]).
	self cCode: ''
		inSmalltalk:
			[| range |
			 range := self cStackRangeForThreadIndex: disowningVMThread index.
			 self assert: (range includes: cogit getCStackPointer).
			 self assert: (range includes: cogit getCFramePointer)].
	cogit recordEventTrace ifTrue:
		[self recordTrace: TracePreemptDisowningThread
			thing: (objectMemory integerObjectOf: disowningVMThread index)
			source: 0].
	disowningVMThread cStackPointer: cogit getCStackPointer.
	disowningVMThread cFramePointer: cogit getCFramePointer.
	activeProc := self activeProcess.
	self assert: (objectMemory fetchPointer: MyListIndex ofObject: activeProc) = objectMemory nilObject.
	objectMemory
		storePointer: MyListIndex
		ofObject: activeProc
		withValue: (objectMemory splObj: ProcessInExternalCodeTag).
	"The instructionPointer must be pushed because the convention for inactive stack pages is that the
	 instructionPointer is top of stack.  We need to know if this primitive is called from machine code
	 because the invariant that the return pc of an interpreter callee calling a machine code caller is
	 ceReturnToInterpreterPC must be maintained."
	self push: instructionPointer.
	self externalWriteBackHeadFramePointers.
	activeContext := self ensureFrameIsMarried: framePointer SP: stackPointer.
	objectMemory
		storePointer: SuspendedContextIndex
		ofObject: activeProc
		withValue: activeContext.
	"Since pushing the awol process may realloc disowningVMThread we need to reassign.
	 But since we're going to nil disowningVMThread anyway we can assign to a local."
	preemptedThread := cogThreadManager pushAWOLProcess: activeProc on: disowningVMThread.
	disowningVMThread := nil.
	preemptedThread priority: (self quickFetchInteger: PriorityIndex ofObject: activeProc).
	(self ownerIndexOfProcess: activeProc) = 0
		ifTrue: [self setOwnerIndexOfProcess: activeProc to: preemptedThread index bind: false]
		ifFalse: [self assert: (self ownerIndexOfProcess: activeProc) = preemptedThread index].
	preemptedThread
		newMethodOrNull: newMethod;
		argumentCount: argumentCount;
		inMachineCode: instructionPointer asUnsignedInteger <= objectMemory startOfMemory.
	self cCode:
			[self mem: preemptedThread reenterInterpreter
				cp: reenterInterpreter
				y: (self sizeof: #'jmp_buf')]
		inSmalltalk:
			[preemptedThread reenterInterpreter: reenterInterpreter]