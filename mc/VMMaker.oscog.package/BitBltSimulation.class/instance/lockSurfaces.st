surface support
lockSurfaces
	"Get a pointer to the bits of any OS surfaces."
	"Notes: 
	* For equal source/dest handles only one locking operation is performed.
	This is to prevent locking of overlapping areas which does not work with
	certain APIs (as an example, DirectDraw prevents locking of overlapping areas). 
	A special case for non-overlapping but equal source/dest handle would 
	be possible but we would have to transfer this information over to 
	unlockSurfaces somehow (currently, only one unlock operation is 
	performed for equal source and dest handles). Also, this would require
	a change in the notion of ioLockSurface() which is right now interpreted
	as a hint and not as a requirement to lock only the specific portion of
	the surface.

	* The arguments in ioLockSurface() provide the implementation with
	an explicit hint what area is affected. It can be very useful to
	know the max. affected area beforehand if getting the bits requires expensive
	copy operations (e.g., like a roundtrip to the X server or a glReadPixel op).
	However, the returned pointer *MUST* point to the virtual origin of the surface
	and not to the beginning of the rectangle. The promise made by BitBlt
	is to never access data outside the given rectangle (aligned to 4byte boundaries!)
	so it is okay to return a pointer to the virtual origin that is actually outside
	the valid memory area.

	* The area provided in ioLockSurface() is already clipped (e.g., it will always
	be inside the source and dest boundingBox) but it is not aligned to word boundaries
	yet. It is up to the support code to compute accurate alignment if necessary.

	* Warping always requires the entire source surface to be locked because
	there is no beforehand knowledge about what area will actually be traversed.

	* Fail if a GC has occurred since the primitive started (presumably in the lockSurface
	   function), because one or more of the primitives' parameters may have been moved.
	"
	| sourceHandle destHandle l r t b |
	<inline: true>
	self assert: numGCsOnInvocation = interpreterProxy statNumGCs.
	hasSurfaceLock := false.
	destBits = 0 ifTrue: "Blitting *to* OS surface"
		[lockSurfaceFn = 0 ifTrue: [self loadSurfacePlugin ifFalse: [^false]].
		 destHandle := interpreterProxy fetchInteger: FormBitsIndex ofObject: destForm.
		 (sourceBits ~= 0 or: [noSource]) ifFalse:
			[sourceHandle := interpreterProxy fetchInteger: FormBitsIndex ofObject: sourceForm.
			 "Handle the special case of equal source and dest handles"
			 sourceHandle = destHandle ifTrue:
				"If we have overlapping source/dest we lock the entire area
				so that there is only one area transmitted"
				[isWarping
					ifFalse: "When warping we always need the entire surface for the source"
						[sourceBits := self lock: sourceHandle
											Su: (self addressOf: sourcePitch)
											rf: 0
											ac: 0
											eF: sourceWidth
											n: sourceHeight]
					ifTrue: "Otherwise use overlapping area"
						[l := sx min: dx. r := (sx max: dx) + bbW.
						t := sy min: dy. b := (sy max: dy) + bbH.
						sourceBits := self lock: sourceHandle
											Su: (self addressOf: sourcePitch)
											rf: l
											ac: t
											eF: r - l
											n: b - t].
				destBits := sourceBits.
				destPitch := sourcePitch.
				hasSurfaceLock := true.
				numGCsOnInvocation ~= interpreterProxy statNumGCs ifTrue:
					[self unlockSurfaces.
					 interpreterProxy primitiveFailFor: PrimErrObjectMoved.
					 ^false].
				destBits = 0 ifTrue:
					[self unlockSurfaces.
					 interpreterProxy primitiveFailFor: PrimErrCallbackError.
					 ^false].
				^true]].
		"Fall through - if not equal it'll be handled below"
		destBits := self lock: destHandle
						Su: (self addressOf: destPitch)
						rf: dx
						ac: dy
						eF: bbW
						n: bbH.
		hasSurfaceLock := true.
		numGCsOnInvocation ~= interpreterProxy statNumGCs ifTrue:
			[self unlockSurfaces.
			 interpreterProxy primitiveFailFor: PrimErrObjectMoved.
			 ^false].
		destBits = 0 ifTrue:
			[interpreterProxy primitiveFailFor: PrimErrCallbackError]].

	(sourceBits ~= 0 or: [noSource]) ifFalse: "Blitting *from* OS surface"
		[sourceHandle := interpreterProxy fetchInteger: FormBitsIndex ofObject: sourceForm.
		 interpreterProxy failed ifTrue: [^false]. "fetch sourceHandle could fail"
		lockSurfaceFn = 0 ifTrue:[self loadSurfacePlugin ifFalse:[^false]].
		"Warping requiring the entire surface"
		isWarping
			ifTrue:
				[sourceBits := self lock: sourceHandle
												Su: (self addressOf: sourcePitch)
												rf: 0
												ac: 0
												eF: sourceWidth
												n: sourceHeight]
			ifFalse:
				[sourceBits := self lock: sourceHandle
									Su: (self addressOf: sourcePitch)
									rf: sx
									ac: sy
									eF: bbW
									n: bbH].
		hasSurfaceLock := true.
		numGCsOnInvocation ~= interpreterProxy statNumGCs ifTrue:
			[self unlockSurfaces.
			 interpreterProxy primitiveFailFor: PrimErrObjectMoved.
			 ^false].
		sourceBits = 0 ifTrue:
			[interpreterProxy primitiveFailFor: PrimErrCallbackError]].
	^destBits ~= 0 and: [sourceBits ~= 0 or: [noSource]]