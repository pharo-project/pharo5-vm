marshalling
nonRegisterStructReturnIsViaImplicitFirstArgument
	"Answer if a struct returned in memory is returned to the
	 referent of a pointer passed as an implciit first argument.
	 It almost always is.  Subclasses can override if not."
	^true