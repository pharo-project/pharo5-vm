I/O primitives
ioShow: destBits D: w i: h s: d p: left l: right a: top y: bottom
	"This is the simulator's implementation of ioShowDisplay."
	| raster pixPerWord simDisp realDisp rect |
	displayForm ifNil: [^self].
	displayBits = 0 ifTrue: [^self].
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
	displayView ifNotNil: [^displayView changed].
	
	"If running without a view, just blat the bits onto the screen..."
	rect := 0 @ top corner: displayForm width @ bottom.
	Display
		copy: (rect translateBy: self displayLocation)
		from: rect topLeft
		in: displayForm
		rule: Form over