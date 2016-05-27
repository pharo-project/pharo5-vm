compile abstract instructions
compileTwoPathFrameBuild
	<option: #IMMUTABILITY>
	"We are in a method where the frame is needed *only* for instance variable store, typically a setter method.
	This case has 20% overhead with Immutability compared to setter without immutability because of the stack
	frame creation. We compile two path, one where the object is immutable, one where it isn't. At the beginning 
	of the frame build, we take one path or the other depending on the receiver mutability.
	
	Note: this specific case happens only where there are only instance variabel stores. We could do something
	similar for literal variable stores, but we don't as it's too uncommon."
	|jumpImmutable|
	self assert: needsFrame.
	self assert: IMMUTABILITY.
	self assert: needsTwoPath.
	self assert: blockCount = 0.
	jumpImmutable := objectRepresentation genJumpImmutable: ReceiverResultReg scratchReg: TempReg.
	"first path. The receiver is mutable"
	self initSimStackForFramelessMethod: initialPC.
	self compileMethodBody.
	"second path. The receiver is mutable"
	needsTwoPath := false. "reset because it impact inst var store compilation"
	jumpImmutable jmpTarget: self Label.
	self genPushRegisterArgs.
	super compileFrameBuild.
	self initSimStackForFramefulMethod: initialPC