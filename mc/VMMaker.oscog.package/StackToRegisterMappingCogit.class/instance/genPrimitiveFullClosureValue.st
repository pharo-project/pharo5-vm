primitive generators
genPrimitiveFullClosureValue
	"Override to push the register args first."
	self break.
	self genPushRegisterArgs.
	^super genPrimitiveFullClosureValue