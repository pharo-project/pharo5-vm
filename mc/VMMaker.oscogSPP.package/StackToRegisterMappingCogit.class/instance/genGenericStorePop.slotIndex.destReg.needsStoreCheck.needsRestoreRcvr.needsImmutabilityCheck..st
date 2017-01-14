bytecode generator stores
genGenericStorePop: popBoolean slotIndex: slotIndex destReg: destReg needsStoreCheck: needsStoreCheck needsRestoreRcvr: needsRestoreReceiver needsImmutabilityCheck: needsImmCheck
	"Generates a store into an object that *cannot* be a context.
	 This code is common between multiple stores (litVar, instVar, remoteInstVar, RemoteTemp)
	 Multiple settings:
	- needsStoreCheck (young into old object check)
	- needRestoreRcvr (ensures the receiver is live across the store)
	- needsImmCheck (do the call-back if the receiver is immutable)"
	<inline: true>
	"We have two very different paths as only the immutability path requires a specific register 
	for the value on top of stack as well as the stack flush"
	| topReg |
	self 
		cppIf: IMMUTABILITY
		ifTrue:
			[needsImmCheck
				ifTrue: 
					[self ssAllocateRequiredReg: ClassReg.
					 "we replace the top value for the flush"
					 self ssStoreAndReplacePop: popBoolean toReg: ClassReg.
					 self ssFlushTo: simStackPtr.
					 ^objectRepresentation 
						genStoreWithImmutabilityCheckSourceReg: ClassReg 
						slotIndex: slotIndex 
						destReg: destReg 
						scratchReg: TempReg 
						needsStoreCheck: needsStoreCheck 
						needRestoreRcvr: needsRestoreReceiver]].
		 topReg := self 
					allocateRegForStackEntryAt: 0 
					notConflictingWith: (self registerMaskFor: destReg). 
		 self ssStorePop: popBoolean toReg: topReg.
		 ^objectRepresentation
			genStoreSourceReg: topReg
			slotIndex: slotIndex
			destReg: destReg
			scratchReg: TempReg
			inFrame: needsFrame
			needsStoreCheck: needsStoreCheck
	