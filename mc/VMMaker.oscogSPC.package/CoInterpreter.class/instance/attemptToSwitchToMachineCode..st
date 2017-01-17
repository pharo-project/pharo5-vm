jump bytecodes
attemptToSwitchToMachineCode: bcpc
	"Attempt to convert the current interpreted activation into a machine code
	 activation, and if this is popssible, jump into machine code.  bcpc is the
	 0-relative pc of the backward branch bytecode (not any preceding extension)."
	| cogMethod pc cls |
	<inline: false>
	<var: #cogMethod type: #'CogMethod *'>
	(self methodHasCogMethod: method)
		ifFalse: 
			[SistaV1BytecodeSet
				ifTrue: 
					[ ((self iframeIsBlockActivation: framePointer) 
					   and: [(self isVanillaBlockClosure: (cls := self frameStackedReceiver: framePointer numArgs: (self frameNumArgs: framePointer))) not ])
						ifTrue: 
							["Compiled block / full closure"
							 cogit cogFullBlockMethod: method numCopied: (objectMemory numPointerSlotsOf: cls) - FullClosureFirstCopiedValueIndex]
						ifFalse: 
							["Compiled method"
							cogit cog: method selector: objectMemory nilObject] ]
				ifFalse: 
					[cogit cog: method selector: objectMemory nilObject] ].
	(self methodHasCogMethod: method) ifTrue:
		[cogMethod := self cogMethodOf: method.
		 pc := self convertToMachineCodeFrame: cogMethod bcpc: bcpc.
		 self assertValidMachineCodeFrame: pc.
		 self push: pc.
		 self push: objectMemory nilObject.
		 cogit ceEnterCogCodePopReceiverReg]