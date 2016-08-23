surface support
unlockSurfaces
	"Unlock the bits of any OS surfaces."
	"See the comment in lockSurfaces. Similar rules apply. That is, the area provided in ioUnlockSurface can be used to determine the dirty region after drawing. If a source is unlocked, then the area will be (0,0,0,0) to indicate that no portion is dirty."
	| sourceHandle destHandle destLocked fn |
	<var: #fn declareC:'sqInt (*fn)(sqInt, sqInt, sqInt, sqInt, sqInt)'>
	hasSurfaceLock ifTrue:[
		unlockSurfaceFn = 0 ifTrue:[self loadSurfacePlugin ifFalse:[^nil]].
		fn := self cCoerce: unlockSurfaceFn to: 'sqInt (*)(sqInt, sqInt, sqInt, sqInt, sqInt)'.
		destLocked := false.
		destHandle := interpreterProxy fetchPointer: FormBitsIndex ofObject: destForm.
		(interpreterProxy isIntegerObject: destHandle) ifTrue:[
			destHandle := interpreterProxy integerValueOf: destHandle.
			"The destBits are always assumed to be dirty"
			self cCode:'fn(destHandle, affectedL, affectedT, affectedR-affectedL, affectedB-affectedT)'.
			destBits := destPitch := 0.
			destLocked := true.
		].
		noSource ifFalse:[
			sourceHandle := interpreterProxy fetchPointer: FormBitsIndex ofObject: sourceForm.
			(interpreterProxy isIntegerObject: sourceHandle) ifTrue:[
				sourceHandle := interpreterProxy integerValueOf: sourceHandle.
				"Only unlock sourceHandle if different from destHandle"
				(destLocked and:[sourceHandle = destHandle]) 
					ifFalse:[self cCode: 'fn(sourceHandle, 0, 0, 0, 0)'].
				sourceBits := sourcePitch := 0.
			].
		].
		hasSurfaceLock := false.
		self cCode: [] inSmalltalk:
			[self touch: fn.
			 interpreterProxy displayObject = destForm ifTrue:
				[interpreterProxy getDeferDisplayUpdates "for some reason this is true..."
					ifTrue:
						[interpreterProxy fullDisplayUpdate]
					ifFalse:
						[interpreterProxy fullDisplayUpdate]]].
	].