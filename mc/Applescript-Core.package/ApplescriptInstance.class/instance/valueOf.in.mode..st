interpreting
valueOf: aCompiledApplescript in: contextOSAID mode: anInteger
	"Answer text result of executing Applescript aString in context contexOSAID in mode: anInteger"

	| sourceAEDesc sourceOSAID objectOSAID objectAEDesc |
	sourceAEDesc := AEDesc scptTypeOn: aCompiledApplescript.
	sourceOSAID := self 
		loadAndDispose: sourceAEDesc 
		mode: anInteger.
	sourceOSAID ifNil: [^nil].
	objectOSAID := self 
		executeAndDispose: sourceOSAID
		in: contextOSAID
		mode: anInteger.
	objectOSAID ifNil: [^nil].
	objectAEDesc := self
		displayAndDispose: objectOSAID
		as: 'ut16'
		mode: anInteger.
	objectAEDesc ifNil: [^nil].
	^objectAEDesc asStringThenDispose