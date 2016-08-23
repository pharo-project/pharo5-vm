color mapping
rgbMapPixel: sourcePixel flags: mapperFlags
	"Perform the RGBA conversion for the given source pixel"
	| val |
	<inline: true>
	val := 			((sourcePixel bitAnd: (cmMaskTable at: 0)) bitShift: (cmShiftTable at: 0) signedIntFromLong).
	val := val bitOr: ((sourcePixel bitAnd: (cmMaskTable at: 1)) bitShift: (cmShiftTable at: 1) signedIntFromLong).
	val := val bitOr: ((sourcePixel bitAnd: (cmMaskTable at: 2)) bitShift: (cmShiftTable at: 2) signedIntFromLong).
		  ^val bitOr: ((sourcePixel bitAnd: (cmMaskTable at: 3)) bitShift: (cmShiftTable at: 3) signedIntFromLong).
