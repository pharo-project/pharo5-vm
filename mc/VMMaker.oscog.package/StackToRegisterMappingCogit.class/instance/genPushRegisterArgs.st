compile abstract instructions
genPushRegisterArgs
	"Ensure that the register args are pushed before the retpc for methods with arity <= self numRegArgs."
	"This won't be as clumsy on a RISC.  But putting the receiver and
	 args above the return address means the CoInterpreter has a
	 single machine-code frame format which saves us a lot of work."
	(regArgsHaveBeenPushed
	 or: [methodOrBlockNumArgs > self numRegArgs]) ifFalse:
		[backEnd genPushRegisterArgsForNumArgs: methodOrBlockNumArgs scratchReg: SendNumArgsReg.
		regArgsHaveBeenPushed := true]