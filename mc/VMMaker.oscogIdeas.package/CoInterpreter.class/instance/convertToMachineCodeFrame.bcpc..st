frame access
convertToMachineCodeFrame: cogHomeMethod bcpc: bcpc
	<var: #cogHomeMethod type: #'CogMethod *'>
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
	"Compute the cog method field"
	(self iframeIsBlockActivation: framePointer)
		ifTrue:
			[closure := self pushedReceiverOrClosureOfFrame: framePointer.
			 (self isVanillaBlockClosure: closure)
				ifTrue:
					[startBcpc := self startPCOfClosure: closure.
					 cogMethod := cogit
										findMethodForStartBcpc: startBcpc
										inHomeMethod: cogHomeMethod]
				ifFalse:
					[startBcpc := self startPCOfMethodHeader: cogHomeMethod methodHeader.
					 cogMethod := self cCoerceSimple: cogHomeMethod to: #'CogBlockMethod *'].
			 methodField := cogMethod asInteger + MFMethodFlagIsBlockFlag]
		ifFalse:
			[startBcpc := self startPCOfMethodHeader: cogHomeMethod methodHeader.
			 cogMethod := self cCoerceSimple: cogHomeMethod to: #'CogBlockMethod *'.
			 methodField := cogHomeMethod asInteger].
	"compute the pc before converting the frame to help with debugging."
	pc := cogit mcPCForBackwardBranch: bcpc startBcpc: startBcpc in: cogMethod.
	self assert: pc > (cogMethod asUnsignedInteger + cogit noCheckEntryOffset).
	self assert: bcpc = (cogit bytecodePCFor: pc startBcpc: startBcpc in: cogMethod).
	"now convert to a machine code frame"
	stackPages
		longAt: framePointer + FoxMethod
		put: methodField
			+ ((self iframeHasContext: framePointer)
				ifTrue: [MFMethodFlagHasContextFlag]
				ifFalse: [0]).
	framePointer + FoxIFReceiver to: stackPointer by: objectMemory wordSize negated do:
		[:p|
		stackPages longAt: p + FoxMFReceiver - FoxIFReceiver put: (stackPages longAt: p)].
	stackPointer := stackPointer + FoxMFReceiver - FoxIFReceiver.
	^pc