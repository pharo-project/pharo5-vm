simulation only
initSegmentForInImageCompilationFrom: base to: limit
	<doNotGenerate>
	| bridge |
	self allocateOrExtendSegmentInfos.
	numSegments := 1.
	bridge := manager initSegmentBridgeWithBytes: manager memory byteSize - limit at: limit - manager bridgeSize.
	segments := {SpurSegmentInfo new
						segStart: base;
						segSize: limit - base;
						yourself}.
	segments := CArrayAccessor on: segments