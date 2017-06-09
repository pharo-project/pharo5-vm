C translation
namesDefinedAtCompileTime
	"Answer the set of names for variables that should be defined at compile time.
	 Some of these get default values during simulation, and hence get defaulted in
	 the various initializeMiscConstants methods.  But that they have values should
	 /not/ cause the code generator to do dead code elimination based on their
	 default values."
	^#(	VMBIGENDIAN
		IMMUTABILITY
		STACKVM COGVM COGMTVM SPURVM
		PharoVM								"Pharo vs Squeak"
		EnforceAccessControl					"Newspeak"
		CheckRememberedInTrampoline		"IMMUTABILITY"
		LLDB)									"As of lldb-370.0.42 Swift-3.1, passing funciton parameters to printOopsSuchThat fails with Internal error [IRForTarget]: Couldn't rewrite one of the arguments of a function call.  Turning off link time optimization with -fno0lto has no effect.  hence we define some debugging functions as being <option: LLDB>"