primitives-Windows-VM-specific
primDrainOSEventQueue
	<export: true>
	self cppIf: #NewspeakVM
		ifTrue: [self ioDrainEventQueue]