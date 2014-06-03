setup
copyBits
	"This function is exported for the Balloon engine"
	<export: true>
	<inline: false>
	self clipRange.
	(bbW <= 0 or: [bbH <= 0]) ifTrue:
		["zero width or height; noop"
		affectedL := affectedR := affectedT := affectedB := 0.
		^ nil].
	"Lock the surfaces"
	self lockSurfaces ifFalse:[^interpreterProxy primitiveFail].

	self
		cppIf: #'ENABLE_FAST_BLT'
		ifTrue:["you really, really mustn't call this unless you have the rest of the code to link to"
			self copyBitsFastPathSpecialised]
		ifFalse:[self copyBitsLockedAndClipped].

	self unlockSurfaces.