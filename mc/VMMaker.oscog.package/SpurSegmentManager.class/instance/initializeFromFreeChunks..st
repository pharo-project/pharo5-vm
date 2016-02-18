simulation only
initializeFromFreeChunks: freeChunks
	<doNotGenerate>
	"For testing, create a set of segments using the freeChunks as bridges."
	self assert: (freeChunks allSatisfy: [:f| manager hasOverflowHeader: f]).
	numSegments := freeChunks size.
	freeChunks do:
		[:f|
		manager initSegmentBridgeWithBytes: (manager bytesInObject: f) at: (manager startOfObject: f).
		self assert: (manager isSegmentBridge: f)].
	segments := (1 to: numSegments) collect:
					[:i| | bridge start size |
					bridge := freeChunks at: i.
					start := i = 1
								ifTrue: [manager newSpaceLimit]
								ifFalse: [manager addressAfter: (freeChunks at: i - 1)].
					size := bridge + manager baseHeaderSize - start.
					SpurSegmentInfo new
						segStart: start;
						segSize: size;
						yourself].
	manager setEndOfMemory: segments last segLimit.
	segments := CArrayAccessor on: segments.
	freeChunks with: segments object do:
		[:bridge :segment|
		self assert: (self isValidSegmentBridge: bridge).
		self assert: bridge = (self bridgeFor: segment)]