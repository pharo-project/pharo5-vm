bezier-loading
loadWideBezier: lineWidth lineFill: lineFill leftFill: leftFill rightFill: rightFill n: nSegments
	"Load the (possibly wide) bezier from the segments currently on the bezier stack."
	| index bezier wide offset |
	<inline: false>
	(lineWidth = 0 or:[lineFill = 0])
		ifTrue:[wide := false.
				offset := 0]
		ifFalse:[wide := true.
				offset := self offsetFromWidth: lineWidth].
	index := nSegments * 6.
	[index > 0] whileTrue:[
		wide 
			ifTrue:[bezier := self allocateWideBezier]
			ifFalse:[bezier := self allocateBezier].
		engineStopped ifTrue:[^0].
		self loadBezier: bezier 
			segment: index 
			leftFill: leftFill 
			rightFill: rightFill 
			offset: offset.
		wide ifTrue:[
			self wideBezierFillOf: bezier put: lineFill.
			self wideBezierWidthOf: bezier put: lineWidth.
			self wideBezierExtentOf: bezier put: lineWidth.
		].
		index := index - 6.
	].
	self wbStackClear.