all
primitiveMapFromToWidthHeightPatchSizeRgbFlagsShift

	| srcOop dstOop w h patchSize rgbFlags shiftAmount src dst rgbMult srcIndex level pixel offset |
	<export: true>
	<var: 'src' type: 'unsigned int *'>
	<var: 'dst' type: 'unsigned int *'>

	srcOop := interpreterProxy stackValue: 6.
	dstOop := interpreterProxy stackValue: 5.
	w := interpreterProxy stackIntegerValue: 4.
	h := interpreterProxy stackIntegerValue: 3.
	patchSize := interpreterProxy stackIntegerValue: 2.
	rgbFlags := interpreterProxy stackIntegerValue: 1.
	shiftAmount := interpreterProxy stackIntegerValue: 0.

	src := self checkedUnsignedIntPtrOf: srcOop.
	dst := self checkedUnsignedIntPtrOf: dstOop.
	interpreterProxy success:
		(interpreterProxy stSizeOf: dstOop) = (w * h).
	interpreterProxy success:
		(interpreterProxy stSizeOf: dstOop) = ((interpreterProxy stSizeOf: srcOop) * patchSize * patchSize).
	interpreterProxy failed ifTrue: [^ nil].

	rgbMult := 0.
	(rgbFlags bitAnd: 2r100) > 0 ifTrue: [rgbMult := rgbMult + 16r10000].
	(rgbFlags bitAnd: 2r10) > 0 ifTrue: [rgbMult := rgbMult + 16r100].
	(rgbFlags bitAnd: 2r1) > 0 ifTrue: [rgbMult := rgbMult + 16r1].
	srcIndex := -1.
	0 to: (h // patchSize) - 1 do: [:y |
		0 to: (w // patchSize) - 1 do: [:x |
			level := (src at: (srcIndex := srcIndex + 1)) bitShift: shiftAmount.
			level > 255 ifTrue: [level := 255].
			level <= 0
				ifTrue: [pixel := 1]  "non-transparent black"
				ifFalse: [pixel := level * rgbMult].

			"fill a patchSize x patchSize square with the pixel value"
			offset := ((y * w) + x) * patchSize.
			offset to: offset + ((patchSize - 1) * w) by: w do: [:rowStart |
				rowStart to: rowStart + patchSize - 1 do: [:dstIndex |
					dst at: dstIndex put: pixel]] ]].

	interpreterProxy pop: 7.  "pop args, leave rcvr on stack"
