object memory support
preGCAction: gcMode

	compilerInitialized
		ifTrue: [self compilerPreGC: gcMode = GCModeFull]
		ifFalse: [self storeContextRegisters: activeContext].