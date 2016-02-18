I/O primitives
showDisplayBits: destBits w: w h: h d: d left: left right: right top: top bottom: bottom
	| raster pixPerWord simDisp realDisp rect |
	displayForm ifNil: [^self].
	pixPerWord := 32 // d.
	raster := displayForm width + (pixPerWord - 1) // pixPerWord.
	simDisp := Form new hackBits: objectMemory memory.
	displayForm unhibernate.
	realDisp := Form new hackBits: displayForm bits.
	realDisp
		copy: (0 @ (top * raster) extent: 4 @ (bottom - top * raster))
		from: 0 @ (destBits // 4 + (top * raster))
		in: simDisp
		rule: Form over.
	displayView ifNotNil: [^ displayView changed].
	
	"If running without a view, just blat the bits onto the screen..."
	rect := 0 @ top corner: displayForm width @ bottom.
	Display
		copy: (rect translateBy: self displayLocation)
		from: rect topLeft
		in: displayForm
		rule: Form over