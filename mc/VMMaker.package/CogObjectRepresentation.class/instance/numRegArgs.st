calling convention
numRegArgs
	"Define how many register arguments a StackToRegisterMappingCogit can and should use
	 with the receiver.  The value must be 0, 1 or 2.  Note that a SimpleStackBasedCogit always
	 has 0 register args (although the receiver is passed in a register).  The method must
	 be inlined in CoInterpreter, and dead code eliminated so that the register-popping
	 enilopmarts such as enterRegisterArgCogMethod:at:receiver: do not have to be
	 implemented in SimpleStackBasedCogit."
	<api>
	<option: #StackToRegisterMappingCogit>
	<inline: true>
	self subclassResponsibility