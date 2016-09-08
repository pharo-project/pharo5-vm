primitive generators
genPrimitiveFullClosureValue
	"Override to push the register args first."
	<option: #SistaV1BytecodeSet>
	self genPushRegisterArgs.
	^super genPrimitiveFullClosureValue