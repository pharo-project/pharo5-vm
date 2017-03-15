initialize-release
moduleUnloaded: aModuleName
	"The module with the given name was just unloaded.
	 Make sure we have no dangling references."
	<export: true>
	<var: #aModuleName type: 'char *'>
	(aModuleName strcmp: 'SurfacePlugin') = 0 ifTrue: "The surface plugin just shut down. How nasty."
		[querySurfaceFn := 0.
		 lockSurfaceFn := 0.
		 unlockSurfaceFn := 0]