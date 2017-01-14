private
interpolatedFrom: bitmap x: xFixed y: yFixed width: w height: h
	"Answer the interpolated pixel value from the given bitmap at the given point. The x and y coordinates are fixed-point integers with 10 bits of fraction (i.e. they were multiplied by 1024, then truncated). If the given point is right on an edge, answer the nearest edge pixel value. If it is entirely outside of the image, answer 0 (transparent)."

	| x y xFrac yFrac index topPix bottomPix |
	<inline: true>
	<var: 'bitmap' declareC: 'unsigned int *bitmap'>

	x := xFixed bitShift: -10.
	(x < -1 or: [x >= w]) ifTrue: [^ 0].
	y := yFixed bitShift: -10.
	(y < -1 or: [y >= h]) ifTrue: [^ 0].

	xFrac := xFixed bitAnd: 1023.
	x = -1 ifTrue: [x := 0. xFrac := 0].  "left edge"
	x = (w - 1) ifTrue: [xFrac := 0].  "right edge"

	yFrac := yFixed bitAnd: 1023.
	y = -1 ifTrue: [y := 0. yFrac := 0].  "top edge"
	y = (h - 1) ifTrue: [yFrac := 0].  "bottom edge"

	index := (y * w) + x "for squeak: + 1".
	topPix := (bitmap at: index) bitAnd: 16rFFFFFF.
	xFrac > 0 ifTrue: [
		topPix := self interpolate: topPix and: ((bitmap at: index + 1) bitAnd: 16rFFFFFF) frac: xFrac].

	yFrac = 0 ifTrue: [^ topPix].  "no y fraction, so just use value from top row"

	index := ((y + 1) * w) + x "for squeak: + 1".
	bottomPix := (bitmap at: index) bitAnd: 16rFFFFFF.
	xFrac > 0 ifTrue: [
		bottomPix := self interpolate: bottomPix and: ((bitmap at: index + 1) bitAnd: 16rFFFFFF) frac: xFrac].

	^ self interpolate: topPix and: bottomPix frac: yFrac
