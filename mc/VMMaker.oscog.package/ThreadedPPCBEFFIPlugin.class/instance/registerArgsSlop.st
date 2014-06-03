marshalling
registerArgsSlop
	"Answer any space needed to prevent the alloca'ed outgoing arguments marshalling area from
	 being overwritten by any register arguments during calls during marshalling.  On PowerPC, which
	 has 8 register arguments in the calling convention, register arguments are also written to the stack.
	 So we must leave room for 8 * 4 bytes to avoid overwriting the marshalling stack as register
	 arguments are written to the stack during calls to interpreterProxy etc."
	^32