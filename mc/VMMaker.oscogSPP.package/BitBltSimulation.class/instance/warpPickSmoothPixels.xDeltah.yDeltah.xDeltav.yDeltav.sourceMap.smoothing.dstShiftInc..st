pixel mapping
warpPickSmoothPixels: nPixels
	xDeltah: xDeltah yDeltah: yDeltah
	xDeltav: xDeltav yDeltav: yDeltav
	sourceMap: sourceMap
	smoothing: n
	dstShiftInc: dstShiftInc
	"Pick n (sub-) pixels from the source form, mapped by sourceMap,
	average the RGB values, map by colorMap and return the new word.
	This version is only called from WarpBlt with smoothingCount > 1"
	| rgb x y a r g b xx yy xdh ydh xdv ydv dstMask destWord i j k nPix |
	<inline: false> "nope - too much stuff in here"
	<var: #rgb type: #'unsigned int'>
	dstMask := maskTable at: destDepth.
	destWord := 0.
	n = 2 "Try avoiding divides for most common n (divide by 2 is generated as shift)"
		ifTrue:[xdh := xDeltah // 2. ydh := yDeltah // 2. 
				xdv := xDeltav // 2. ydv := yDeltav // 2]
		ifFalse:[xdh := xDeltah // n. ydh := yDeltah // n. 
				xdv := xDeltav // n. ydv := yDeltav // n].
	i := nPixels.
	[
		x := sx. y := sy.
		a := r := g := b := 0.
		"Pick and average n*n subpixels"
		nPix := 0.  "actual number of pixels (not clipped and not transparent)"
		j := n.
		[
			xx := x. yy := y.
			k := n.
			[
				"get a single subpixel"
				rgb := self pickWarpPixelAtX: xx y: yy.
				(combinationRule=25 "PAINT" and: [rgb = 0]) ifFalse:[
					"If not clipped and not transparent, then tally rgb values"
					nPix := nPix + 1.
					sourceDepth < 16 ifTrue:[
						"Get RGBA values from sourcemap table"
						rgb := self long32At: sourceMap + (rgb << 2).
					] ifFalse:["Already in RGB format"
						sourceDepth = 16 
								ifTrue:[rgb := self rgbMap16To32: rgb]
								ifFalse:[rgb := self rgbMap32To32: rgb]].
					b := b + (rgb bitAnd: 255).
					g := g + (rgb >> 8 bitAnd: 255).
					r := r + (rgb >> 16 bitAnd: 255).
					a := a + (rgb >> 24)].
				xx := xx + xdh.
				yy := yy + ydh.
			(k := k - 1) = 0] whileFalse.
			x := x + xdv.
			y := y + ydv.
		(j := j - 1) = 0] whileFalse.

		(nPix = 0 or: [combinationRule=25 "PAINT" and: [nPix < (n * n // 2)]]) ifTrue:[
			rgb := 0  "All pixels were 0, or most were transparent"
		] ifFalse:[
			"normalize rgba sums"
			nPix = 4 "Try to avoid divides for most common n"
				ifTrue:[r := r >> 2.	g := g >> 2.	b := b >> 2.	a := a >> 2]
				ifFalse:[	r := r // nPix.	g := g // nPix.	b := b // nPix.	a := a // nPix].
			rgb := (a << 24) + (r << 16) + (g << 8) + b.

			"map the pixel"
			rgb = 0 ifTrue: [
				"only generate zero if pixel is really transparent"
				(r + g + b + a) > 0 ifTrue: [rgb := 1]].
			rgb := self mapPixel: rgb flags: cmFlags.
		].
		"Mix it in"
		destWord := destWord bitOr: (rgb bitAnd: dstMask) << dstBitShift.
		dstBitShift := dstBitShift + dstShiftInc.
		sx := sx + xDeltah.
		sy := sy + yDeltah.
	(i := i - 1) = 0] whileFalse.

	^destWord
