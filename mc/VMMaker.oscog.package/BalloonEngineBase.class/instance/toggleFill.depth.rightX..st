FILL processing
toggleFill: fillIndex depth: depth rightX: rightX
	"Make the fill style with the given index either visible or invisible"
	| hidden |
	<inline: false>

	self stackFillSize = 0 ifTrue:[
		(self allocateStackFillEntry) ifTrue:[
			self topFillValuePut: fillIndex.
			self topFillDepthPut: depth.
			self topFillRightXPut: rightX.
		].
	] ifFalse:[
		hidden := self hideFill: fillIndex depth: depth.
		hidden ifFalse:[self showFill: fillIndex depth: depth rightX: rightX].
	].