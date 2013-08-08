system primitives
moduleUnloaded: aModuleName 
	"The module with the given name was just unloaded. 
	Make sure we have no dangling references."
	<export: true>
	<var: #aModuleName type: 'char *'>
	(aModuleName strcmp: 'QuicktimePlugin') = 0
		ifTrue: [self sqQuicktimeShutdown]