shapes-compressed
loadCompressedShape: points segments: nSegments leftFills: leftFills rightFills: rightFills lineWidths: lineWidths lineFills: lineFills fillIndexList: fillIndexList pointShort: pointsShort
	"Load a compressed shape into the engine.
		WARNING: THIS METHOD NEEDS THE FULL FRAME SIZE!!!!
	"
	| leftRun rightRun widthRun lineFillRun
	leftLength rightLength widthLength lineFillLength
	leftValue rightValue widthValue lineFillValue |

	<inline: false>
	<var: #points type:'int *'>
	<var: #leftFills type:'int *'>
	<var: #rightFills type:'int *'>
	<var: #lineWidths type:'int *'>
	<var: #lineFills type:'int *'>
	<var: #fillIndexList type:'int *'>

	nSegments = 0 ifTrue:[^0].

	"Initialize run length encodings"
	leftRun :=  rightRun := widthRun := lineFillRun := -1.
	leftLength := rightLength := widthLength := lineFillLength := 1.
	leftValue := rightValue := widthValue := lineFillValue := 0.

	1 to: nSegments do:[:i|
		"Decrement current run length and load new stuff"
		(leftLength := leftLength - 1) <= 0 ifTrue:[
			leftRun := leftRun + 1.
			leftLength := self shortRunLengthAt: leftRun from: leftFills.
			leftValue := self shortRunValueAt: leftRun from: leftFills.
			leftValue = 0 ifFalse:[
				leftValue := fillIndexList at: leftValue-1.
				leftValue := self transformColor: leftValue.
				engineStopped ifTrue:[^nil]]].
		(rightLength := rightLength - 1) <= 0 ifTrue:[
			rightRun := rightRun + 1.
			rightLength := self shortRunLengthAt: rightRun from: rightFills.
			rightValue := self shortRunValueAt: rightRun from: rightFills.
			rightValue = 0 ifFalse:[
				rightValue := fillIndexList at: rightValue-1.
				rightValue := self transformColor: rightValue]].
		(widthLength := widthLength - 1) <= 0 ifTrue:[
			widthRun := widthRun + 1.
			widthLength := self shortRunLengthAt: widthRun from: lineWidths.
			widthValue := self shortRunValueAt: widthRun from: lineWidths.
			widthValue = 0 ifFalse:[widthValue := self transformWidth: widthValue]].
		(lineFillLength := lineFillLength - 1) <= 0 ifTrue:[
			lineFillRun := lineFillRun + 1.
			lineFillLength := self shortRunLengthAt: lineFillRun from: lineFills.
			lineFillValue := self shortRunValueAt: lineFillRun from: lineFills.
			lineFillValue = 0 ifFalse:[lineFillValue := fillIndexList at: lineFillValue-1]].
		self loadCompressedSegment: i - 1
			from: points 
			short: pointsShort 
			leftFill: leftValue 
			rightFill: rightValue 
			lineWidth: widthValue 
			lineColor: lineFillValue.
		engineStopped ifTrue:[^nil].
	].