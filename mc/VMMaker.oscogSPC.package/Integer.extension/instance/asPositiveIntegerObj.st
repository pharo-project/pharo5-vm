*VMMaker-interpreter simulator
asPositiveIntegerObj
	"This is a SmartSyntaxPlugin convenience, invented with little thought for simulation (grrr).
	  In the VM this is equivalent to
		interpreterProxy methodReturnValue: (interpreterProxy positive32BitIntegerFor: self)
	 but if a plugin is being developed I /think/ it is just
		^self
	 So search the stack to discover what context it is being used in."
	(thisContext findContextSuchThat: [:ctxt| ctxt receiver isInterpreterPlugin]) ifNotNil:
		[:ctxt| | interpreter |
		interpreter := ctxt receiver getInterpreter.
		interpreter methodReturnValue: (interpreter positive32BitIntegerFor: self)].
	^self