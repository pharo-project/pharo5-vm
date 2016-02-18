primitive generators
genPrimitiveClosureValue
	"Defer to the cogit for this one.  This is for two reasons:
	 a)	Cogit's version speeds up cull: et al by not calling the interpreter primitive if numArgs is wrong.
		Our convention for compiling the interpreter primitive call doesn't agree with this usage.
	b)	Cogit refuses to compile primitiveClosureValueNoContextSwitch until the blockNoContextSwitchOffset
		is known, and that isn't information the CogObjectRepresentation is privvy to."
	<doNotGenerate>
	^cogit genPrimitiveClosureValue