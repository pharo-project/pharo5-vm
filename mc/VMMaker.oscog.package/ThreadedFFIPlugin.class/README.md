This plugin provides access to foreign function interfaces on those platforms that provide such. For example Windows DLLs and unix .so's.  This version is designed to support reentrancy and threading, and so uses alloca to stack allocate all memory needed for a given callout.  Specific platforms are implemented by concrete subclasses.  Threaded calls can only be provided within the context of the threaded VM; othewise calls must be blocking.  So code specific to threading is guarded with a
	self cppIf: COGMTVM
		ifTrue: [...]
form to arrange that it is only compiled in the threaded VM context.