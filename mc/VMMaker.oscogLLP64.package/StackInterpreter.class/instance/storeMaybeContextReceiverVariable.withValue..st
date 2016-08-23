stack bytecodes
storeMaybeContextReceiverVariable: fieldIndex withValue: anObject
	"Must trap accesses to married and widowed contexts.
	 But don't want to check on all inst var accesses.  This
	 method is only used by the long-form bytecodes, evading the cost."
	self storeMaybeContext: self receiver receiverVariable: fieldIndex withValue: anObject
