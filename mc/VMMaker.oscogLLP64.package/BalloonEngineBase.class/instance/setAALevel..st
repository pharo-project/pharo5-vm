other
setAALevel: level
	"Set the anti-aliasing level. Three levels are supported:
		1 - No antialiasing
		2 - 2x2 unweighted anti-aliasing
		4 - 4x4 unweighted anti-aliasing.
	"
	| aaLevel |
	<inline: false>
	level >= 4 ifTrue:[aaLevel := 4].
	(level >= 2) & (level < 4) ifTrue:[aaLevel := 2].
	level < 2 ifTrue:[aaLevel := 1].
	self aaLevelPut: aaLevel.
	aaLevel = 1 ifTrue:[
		self aaShiftPut: 0.
		self aaColorMaskPut: 16rFFFFFFFF.
		self aaScanMaskPut: 0.
	].
	aaLevel = 2 ifTrue:[
		self aaShiftPut: 1.
		self aaColorMaskPut: 16rFCFCFCFC.
		self aaScanMaskPut: 1.
	].
	aaLevel = 4 ifTrue:[
		self aaShiftPut: 2.
		self aaColorMaskPut: 16rF0F0F0F0.
		self aaScanMaskPut: 3.
	].
	self aaColorShiftPut: self aaShiftGet * 2.
	self aaHalfPixelPut: self aaShiftGet.
