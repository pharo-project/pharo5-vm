compile abstract instructions
compileTwoPathFramelessInit
	"We are in a frameless method with at least two inst var stores. We compile two paths,
	 one where the object is in new space, and one where it isn't. At the beginning 
	 of the method, we take one path or the other depending on the receiver being in newSpace."
	| jumpOld |
	self deny: IMMUTABILITY.
	self deny: needsFrame.
	self assert: useTwoPaths.
	jumpOld := objectRepresentation genJumpInOldSpace: ReceiverResultReg.
	"first path. The receiver is young"
	self initSimStackForFramelessMethod: initialPC.
	self compileMethodBody.
	"second path. The receiver is old"
	useTwoPaths := false. "reset because it impacts inst var store compilation"
	jumpOld jmpTarget: self Label