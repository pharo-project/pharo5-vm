testing
profileSends: nBytecodes
	"(InterpreterSimulator new openOn: 'clonex.image') profileSends: 5000"
	MessageTally tallySendsTo: self
		inBlock: [self runForNBytes: nBytecodes]
		showTree: true.
	self close