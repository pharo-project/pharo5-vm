color mapping
rgbMap16To32: sourcePixel
	"Convert the given 16bit pixel value to a 32bit RGBA value.
 	Note: This method is intended to deal with different source formats."
	^(((sourcePixel bitAnd: 31) << 3) bitOr:
		((sourcePixel bitAnd: 16r3E0) << 6)) bitOr:
			((sourcePixel bitAnd: 16r7C00) << 9)