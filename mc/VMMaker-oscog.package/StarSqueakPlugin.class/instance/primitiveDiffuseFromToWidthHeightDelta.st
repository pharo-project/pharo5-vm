all
primitiveDiffuseFromToWidthHeightDelta
	"Diffuse the integer values of the source patch variable Bitmap into the output Bitmap. Each cell of the output is the average of the NxN area around it in the source, where N = (2 * delta) + 1."

	| srcOop dstOop height width delta src dst area startY endY startX endX sum rowStart |
	<export: true>
	<var: 'src' type: 'unsigned int *'>
	<var: 'dst' type: 'unsigned int *'>

	srcOop := interpreterProxy stackValue: 4.
	dstOop := interpreterProxy stackValue: 3.
	width := interpreterProxy stackIntegerValue: 2.
	height := interpreterProxy stackIntegerValue: 1.
	delta := interpreterProxy stackIntegerValue: 0.
	src := self checkedUnsignedIntPtrOf: srcOop.
	dst := self checkedUnsignedIntPtrOf: dstOop.
	interpreterProxy success:
		(interpreterProxy stSizeOf: srcOop) = (interpreterProxy stSizeOf: dstOop).
	interpreterProxy success:
		(interpreterProxy stSizeOf: srcOop) = (width * height).
	interpreterProxy failed ifTrue: [^ nil].

	area := ((2 * delta) + 1) * ((2 * delta) + 1).
	0 to: height - 1 do: [:y |
		startY := y - delta.
		startY < 0 ifTrue: [startY := 0].
		endY := y + delta.
		endY >= height ifTrue: [endY := height - 1].
		0 to: width - 1 do: [:x |
			startX := x - delta.
			startX < 0 ifTrue: [startX := 0].
			endX := x + delta.
			endX >= width ifTrue: [endX := width - 1].

			sum := 0.
			startY to: endY do: [:y2 |
				rowStart := y2 * width.
				startX to: endX do: [:x2 |
					sum := sum + (src at: rowStart + x2)]].

			dst at: ((y * width) + x) put: (sum // area)]].

	interpreterProxy pop: 5.  "pop args, leave rcvr on stack"
