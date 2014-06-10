jump bytecodes
attemptToSwitchToMachineCode: bcpc
	| cogMethod pc |
	<inline: #false>
	<var: #cogMethod type: #'CogMethod *'>
	(self methodHasCogMethod: method) ifFalse:
		[cogit cog: method selector: objectMemory nilObject].
	(self methodHasCogMethod: method) ifTrue:
		[cogMethod := self cogMethodOf: method.
		 pc := self convertToMachineCodeFrame: cogMethod bcpc: bcpc.
		 self assertValidMachineCodeFrame: pc.
		 self push: pc.
		 self push: objectMemory nilObject.
		 cogit ceEnterCogCodePopReceiverReg]