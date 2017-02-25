primitive support
allObjectsUnmarked
	self allObjectsDo:
		[:o| (self isMarked: o) ifTrue: [^false]].
	^true