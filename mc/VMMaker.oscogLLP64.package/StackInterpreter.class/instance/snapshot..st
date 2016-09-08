image save/restore
snapshot: embedded 
	"update state of active context"
	| activeContext activeProc rcvr setMacType stackIndex |
	<var: #setMacType type: #'void *'>

	"For now the stack munging below doesn't deal with more than one argument.
	 It can, and should."
	argumentCount ~= 0 ifTrue:
		[^self primitiveFailFor: PrimErrBadNumArgs].

	"Need to convert all frames into contexts since the snapshot file only holds objects."
	self push: instructionPointer.
	activeContext := self voidVMStateForSnapshotFlushingExternalPrimitivesIf: true.

	"update state of active process"
	activeProc := self activeProcess.
	objectMemory
		storePointer: SuspendedContextIndex
		ofObject: activeProc
		withValue: activeContext.

	tempOop := activeContext.
	objectMemory garbageCollectForSnapshot.
	"Nothing moves from here on so it is safe to grab the activeContext again."
	activeContext := tempOop.
	tempOop := 0.

	self successful ifTrue:
		["Without contexts or stacks simulate
			rcvr := self popStack. ''pop rcvr''
			self push: trueObj.
		  to arrange that the snapshot resumes with true.  N.B. stackIndex is one-relative."
		stackIndex := self quickFetchInteger: StackPointerIndex ofObject: activeContext.
		rcvr := objectMemory fetchPointer: stackIndex + CtxtTempFrameStart - 1 ofObject: activeContext.
		objectMemory
			storePointerUnchecked: stackIndex + CtxtTempFrameStart - 1
			ofObject: activeContext
			withValue: objectMemory trueObject.
		"now attempt to write the snapshot file"
		self writeImageFileIO.
		(self successful and: [embedded not]) ifTrue:
			["set Mac file type and creator; this is a noop on other platforms"
			setMacType := self ioLoadFunction: 'setMacFileTypeAndCreator' From: 'FilePlugin'.
			setMacType = 0 ifFalse:
				[self cCode: '((sqInt (*)(char *, char *, char *))setMacType)(imageName, "STim", "FAST")']].
		"Without contexts or stacks simulate
			self pop: 1"
		objectMemory
			storePointerUnchecked: StackPointerIndex
			ofObject: activeContext
			withValue: (objectMemory integerObjectOf: stackIndex - 1)].

	objectMemory postSnapshot.
	self marryContextInNewStackPageAndInitializeInterpreterRegisters: activeContext.
	self successful
		ifTrue: [self push: objectMemory falseObject]
		ifFalse:
			[self push: rcvr.
			 self justActivateNewMethod]