bytecode generator support
createsClosuresInline
	"Answer if the object representation allocates closures inline.  By
	 default answer false. Better code can be generated when creating
	 closures inline if copied values are /not/ flushed to the stack."
	^true