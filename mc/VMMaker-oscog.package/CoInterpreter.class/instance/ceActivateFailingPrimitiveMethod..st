enilopmarts
ceActivateFailingPrimitiveMethod: aPrimitiveMethod
	"An external call or FFI primitive has failed.  Build the frame and
	 activate as appropriate.  Enter either the interpreter or machine
	 code depending on whether aPrimitiveMethod has been or is still
	 cogged.  Note that we could always interpret but want the efficiency
	 of executing machine code if it is available."
	<api>
	| methodHeader |
	self assert: newMethod = aPrimitiveMethod.
	methodHeader := self rawHeaderOf: aPrimitiveMethod.
	(self isCogMethodReference: methodHeader)
		ifTrue: [self activateCoggedNewMethod: false]
		ifFalse: [self activateNewMethod]