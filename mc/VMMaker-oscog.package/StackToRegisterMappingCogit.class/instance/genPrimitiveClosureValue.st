primitive generators
genPrimitiveClosureValue
	"Check the argument count.  Fail if wrong.
	 Get the method from the outerContext and see if it is cogged.  If so, jump to the
	 block entry or the no-context-switch entry, as appropriate, and we're done.  If not,
	 invoke the interpreter primitive.
	 Override to push the register args first."
	self genPushRegisterArgs.
	^super genPrimitiveClosureValue