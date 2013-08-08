generic scripting component
generic
	"Answer an ApplescriptInstance (Applescript Generic Scripting Component) that is guaranteed to be active from startUp, but is not (at present) guaranteed to be identical across startups.  Additional instances can be created for multi-threaded applications by using ApplescriptInstance."

	^ApplescriptGeneric ifNil:
		[ApplescriptGeneric := ApplescriptInstance new]