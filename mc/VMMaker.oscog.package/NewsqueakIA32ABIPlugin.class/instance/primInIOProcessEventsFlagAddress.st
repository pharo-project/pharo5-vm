primitives-Windows-VM-specific
primInIOProcessEventsFlagAddress
	"Answer the address of the int inIOProcessEvents flag.  This can be used to
	 disable invocation of ioProcessEvents and is for backward-compatibility.
	 Please use the core VM primitiveEventProcessingControl in new code."
	| inIOProcessEvents |
	<export: true>
	<var: 'inIOProcessEvents' declareC: 'extern int inIOProcessEvents'>
	self cCode: '' inSmalltalk: [inIOProcessEvents = 0].
	interpreterProxy methodReturnValue: (self positiveMachineIntegerFor: (self addressOf: inIOProcessEvents) asUnsignedInteger)