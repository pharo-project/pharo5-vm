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
		CheckRememberedInTrampoline)		"IMMUTABILITY"