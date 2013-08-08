interpreter interface
drawLoopX: xDelta Y: yDelta 
	"This is the primitive implementation of the line-drawing loop.
	See the comments in BitBlt>>drawLoopX:Y:"
	| dx1 dy1 px py P affL affR affT affB |
	xDelta > 0
		ifTrue: [dx1 := 1]
		ifFalse: [xDelta = 0
				ifTrue: [dx1 := 0]
				ifFalse: [dx1 := -1]].
	yDelta > 0
		ifTrue: [dy1 := 1]
		ifFalse: [yDelta = 0
				ifTrue: [dy1 := 0]
				ifFalse: [dy1 := -1]].
	px := yDelta abs.
	py := xDelta abs.
	affL := affT := 9999.  "init null rectangle"
	affR := affB := -9999.
	py > px
		ifTrue: 
			["more horizontal"
			P := py // 2.
			1 to: py do: 
				[:i |
				destX := destX + dx1.
				(P := P - px) < 0 ifTrue: 
					[destY := destY + dy1.
					P := P + py].
				i < py ifTrue:
					[self copyBits.
					interpreterProxy failed ifTrue:
						[^ nil "bail out now on failure -- avoid storing x,y"].
					(affectedL < affectedR and: [affectedT < affectedB]) ifTrue:
						["Affected rectangle grows along the line"
						affL := affL min: affectedL.
						affR := affR max: affectedR.
						affT := affT min: affectedT.
						affB := affB max: affectedB.
						(affR - affL) * (affB - affT) > 4000 ifTrue:
							["If affected rectangle gets large, update it in chunks"
							affectedL := affL.  affectedR := affR.
							affectedT := affT.  affectedB := affB.
							self showDisplayBits.
							affL := affT := 9999.  "init null rectangle"
							affR := affB := -9999]].
					]]]
		ifFalse: 
			["more vertical"
			P := px // 2.
			1 to: px do:
				[:i |
				destY := destY + dy1.
				(P := P - py) < 0 ifTrue: 
					[destX := destX + dx1.
					P := P + px].
				i < px ifTrue:
					[self copyBits.
					interpreterProxy failed ifTrue:
						[^ nil "bail out now on failure -- avoid storing x,y"].
					(affectedL < affectedR and: [affectedT < affectedB]) ifTrue:
						["Affected rectangle grows along the line"
						affL := affL min: affectedL.
						affR := affR max: affectedR.
						affT := affT min: affectedT.
						affB := affB max: affectedB.
						(affR - affL) * (affB - affT) > 4000 ifTrue:
							["If affected rectangle gets large, update it in chunks"
							affectedL := affL.  affectedR := affR.
							affectedT := affT.  affectedB := affB.
							self showDisplayBits.
							affL := affT := 9999.  "init null rectangle"
							affR := affB := -9999]].
					]]].

	"Remaining affected rect"
	affectedL := affL.  affectedR := affR.
	affectedT := affT.  affectedB := affB.

	"store destX, Y back"	
	interpreterProxy storeInteger: BBDestXIndex ofObject: bitBltOop withValue: destX.
	interpreterProxy storeInteger: BBDestYIndex ofObject: bitBltOop withValue: destY.