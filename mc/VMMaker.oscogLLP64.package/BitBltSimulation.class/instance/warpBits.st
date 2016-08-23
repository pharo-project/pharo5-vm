setup
warpBits
	| ns |
	<inline: true>
	ns := noSource.  noSource := true.
		self clipRange.  "noSource suppresses sourceRect clipping"
		noSource := ns.
	(noSource or: [bbW <= 0 or: [bbH <= 0]]) ifTrue:
		["zero width or height; noop"
		affectedL := affectedR := affectedT := affectedB := 0.
		^ nil].

	self lockSurfaces ifFalse:[^interpreterProxy primitiveFail].
	self destMaskAndPointerInit.
	self warpLoop.
 
	hDir > 0
		ifTrue: [affectedL := dx.
				affectedR := dx + bbW]
		ifFalse: [affectedL := dx - bbW + 1.
				affectedR := dx + 1].
	vDir > 0
		ifTrue: [affectedT := dy.
				affectedB := dy + bbH]
		ifFalse: [affectedT := dy - bbH + 1.
				affectedB := dy + 1].
	self unlockSurfaces.