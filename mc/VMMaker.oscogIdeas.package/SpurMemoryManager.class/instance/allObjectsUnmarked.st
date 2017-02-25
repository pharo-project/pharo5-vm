gc - global
allObjectsUnmarked
	self allObjectsDo:
		[:o| (self isMarked: o) ifTrue: [bogon := o. ^false]].
	^true