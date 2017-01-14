initialize-release
moduleUnloaded: aModuleName 
	"The module with the given name was just unloaded. 
	Make sure we have no dangling references."
	<export: true>
	<var: #aModuleName type: 'char *'>
	(aModuleName strcmp: 'SecurityPlugin') = 0
		ifTrue: ["The security plugin just shut down. How odd. Zero the function pointer we have into it"
			sCOAFfn := 0]