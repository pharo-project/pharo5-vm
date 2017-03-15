surface support
unlockSurfaces
	"Unlock the bits of any OS surfaces."
	"See the comment in lockSurfaces. Similar rules apply. That is, the area provided in ioUnlockSurface
	 can be used to determine the dirty region after drawing. If a source is unlocked, then the area will
	 be (0,0,0,0) to indicate that no portion is dirty.  Note that if a GC happens during unlockSourceFn
	 (if it is effectively a callback) no matter.  No bits are touched after unlock."
	| sourceHandle destHandle destLocked |
	hasSurfaceLock ifFalse: [^self].
	unlockSurfaceFn = 0 ifTrue:
		[self loadSurfacePlugin ifFalse:
			[^self]].
	self ensureDestAndSourceFormsAreValid.
	destLocked := false.
	destHandle := interpreterProxy fetchPointer: FormBitsIndex ofObject: destForm.
	(interpreterProxy isIntegerObject: destHandle) ifTrue: "The destBits are always assumed to be dirty"
		[self unlock: (interpreterProxy integerValueOf: destHandle)
			Sur: affectedL
			fa: affectedT
			ce: affectedR - affectedL
			Fn: affectedB - affectedT.
		 destBits := destPitch := 0.
		 destLocked := true].
	noSource ifFalse:
		[self ensureDestAndSourceFormsAreValid.
		 sourceHandle := interpreterProxy fetchPointer: FormBitsIndex ofObject: sourceForm.
		 (interpreterProxy isIntegerObject: sourceHandle) ifTrue:
			["Only unlock sourceHandle if different from destHandle"
			 (destLocked and: [sourceHandle = destHandle]) ifFalse:
				[self unlock: (interpreterProxy integerValueOf: sourceHandle) Sur: 0 fa: 0 ce: 0 Fn: 0].
			sourceBits := sourcePitch := 0]].
	hasSurfaceLock := false.
	self cCode: [] inSmalltalk:
		[interpreterProxy displayObject = destForm ifTrue:
			[interpreterProxy getDeferDisplayUpdates ifFalse:
				[interpreterProxy fullDisplayUpdate]]]