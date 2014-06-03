primitives-Windows-VM-specific
primInIOProcessEventsFlagAddress
	"Answer the address of the int inIOProcessEvents flag.  This can be used to
	 disable invocation of ioProcessEvents and is for backward-compatibility.
	 Please use the core VM primitiveEventProcessingControl in new code."
	| address |
	<export: true>
	self
		cCode: '{ extern int inIOProcessEvents; address = (sqInt)&inIOProcessEvents; }'
		inSmalltalk: [address := 0].
	interpreterProxy methodReturnValue: (interpreterProxy positive32BitIntegerFor: address)