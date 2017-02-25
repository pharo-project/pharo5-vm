bytecode generator support
createsArraysInline
	"Answer if the object representation allocates arrays inline.  By
	 default answer false. Better code can be generated when creating
	 arrays inline if values are /not/ flushed to the stack."
	^true