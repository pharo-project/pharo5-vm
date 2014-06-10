frame access
convertToMachineCodeFrame: cogHomeMethod bcpc: bcpc
	<var: #cogHomeMethod type: #'CogHomeMethod *'>
	<returnTypeC: #usqInt>
	"Convert the current interpreter frame into a machine code frame
	 and answer the machine code pc matching bcpc."
	| startBcpc methodField closure cogMethod pc |
	<var: #cogMethod type: #'CogBlockMethod *'>
	<var: #p type: #'char *'>
	self assert: (self isMachineCodeFrame: framePointer) not.
	"Update the return pc, perhaps saving it in the caller's iframeSavedIP."
	(self isBaseFrame: framePointer)
		ifTrue:
			[stackPages
				longAt: framePointer + FoxCallerSavedIP
				put: cogit ceBaseFrameReturnPC]
		ifFalse:
			[(self isMachineCodeFrame: (self frameCallerFP: framePointer)) ifFalse:
				[self iframeSavedIP: (self frameCallerFP: framePointer)
					put: (self frameCallerSavedIP: framePointer) asInteger.
				 stackPages
					longAt: framePointer + FoxCallerSavedIP
					put: cogit ceReturnToInterpreterPC]].
	"Set the cog method field"
	(self iframeIsBlockActivation: framePointer)
		ifTrue:
			[closure := self pushedReceiverOrClosureOfFrame: framePointer.
			 startBcpc := self startPCOfClosure: closure.
			 cogMethod := cogit
								findMethodForStartBcpc: startBcpc
								inHomeMethod: cogHomeMethod.
			 methodField := cogMethod asInteger + MFMethodFlagIsBlockFlag]
		ifFalse:
			[startBcpc := self startPCOfMethodHeader: cogHomeMethod methodHeader.
			 cogMethod := self cCoerceSimple: cogHomeMethod to: #'CogBlockMethod *'.
			 methodField := cogHomeMethod asInteger].
	stackPages
		longAt: framePointer + FoxMethod
		put: methodField
			+ ((self iframeHasContext: framePointer)
				ifTrue: [MFMethodFlagHasContextFlag]
				ifFalse: [0]).
	framePointer + FoxIFReceiver to: stackPointer by: BytesPerWord negated do:
		[:p|
		stackPages longAt: p + FoxMFReceiver - FoxIFReceiver put: (stackPages longAt: p)].
	stackPointer := stackPointer + FoxMFReceiver - FoxIFReceiver.
	pc := cogit mcPCForBackwardBranch: bcpc startBcpc: startBcpc in: cogMethod.
	self assert: pc > (cogMethod asUnsignedInteger + cogit noCheckEntryOffset).
	^pc