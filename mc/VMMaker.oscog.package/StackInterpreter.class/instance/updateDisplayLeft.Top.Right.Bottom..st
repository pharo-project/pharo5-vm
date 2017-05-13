I/O primitive support
updateDisplayLeft: l Top: t Right: r Bottom: b
	"Repaint the portion of the Smalltalk screen bounded by the affected rectangle.
	 Used to synchronize the screen after a Bitblt to the Smalltalk Display object."
	| left right top bottom surfaceHandle |
	left := l max: 0.
	right := r min: displayWidth.
	top := t max: 0.
	bottom := b min: displayHeight.
	(left <= right and: [top <= bottom]) ifFalse: [^nil].
	(objectMemory isIntegerObject: displayBits asInteger)
		ifTrue:
			[surfaceHandle := objectMemory integerValueOf: displayBits asInteger.
			 showSurfaceFn = 0 ifTrue:
				[showSurfaceFn := self ioLoadFunction: 'ioShowSurface' From: 'SurfacePlugin'.
				 showSurfaceFn = 0 ifTrue: [^self primitiveFailFor: PrimErrNotFound]].
			 self show: surfaceHandle Sur: left fa: top ce: right - left Fn: bottom - top]
		ifFalse:
			[self assert: (objectMemory isNonImmediate: displayBits asInteger).
			 self ioShow: displayBits asInteger
				D: displayWidth i: displayHeight s: displayDepth
				p: left l: right a: top y: bottom]