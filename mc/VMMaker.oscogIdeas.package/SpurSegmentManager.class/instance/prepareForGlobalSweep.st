pinning
prepareForGlobalSweep
	"Let the segmentManager mark which segments contain pinned objects via notePinned:.
	 For coallesceFreeChunk:, ensure that the last bridge is marked."
	sweepIndex := 0.
	0 to: numSegments - 1 do:
		[:i| (segments at: i) containsPinned: false].
	manager
		setIsMarkedOf: (self bridgeAt: numSegments - 1)
		to: true