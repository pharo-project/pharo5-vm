lines-loading
loadWideLine: lineWidth from: p1 to: p2 lineFill: lineFill leftFill: leftFill rightFill: rightFill
	"Load a (possibly wide) line defined by the points p1 and p2"
	| line offset |
	<var: #p1 type:'int *'>
	<var: #p2 type:'int *'>
	(lineWidth = 0 or:[lineFill = 0])
		ifTrue:[	line := self allocateLine.
				offset := 0]
		ifFalse:[	line := self allocateWideLine.
				offset := self offsetFromWidth: lineWidth].
	engineStopped ifTrue:[^0].
	self loadLine: line 
		from: p1
		to: p2
		offset: offset 
		leftFill: leftFill
		rightFill: rightFill.
	(self isWide: line) ifTrue:[
		self wideLineFillOf: line put: lineFill.
		self wideLineWidthOf: line put: lineWidth.
		self wideLineExtentOf: line put: lineWidth].