fills-bitmaps
bitmapValue: bmFill bits: bits atX: xp y: yp

	| bmDepth bmRaster value rShift cMask r g b a |
	<inline: true>

	bmDepth := self bitmapDepthOf: bmFill.
	bmRaster := self bitmapRasterOf: bmFill.
	bmDepth = 32 ifTrue: [
		value := (self cCoerce: bits to:'int*') at: (bmRaster * yp) + xp.
		(value ~= 0 and: [(value bitAnd: 16rFF000000) = 0])
				ifTrue: [value := value bitOr: 16rFF000000].
		^self uncheckedTransformColor: value].
	"rShift - shift value to convert from pixel to word index"
	rShift := self rShiftTable at: bmDepth.
	value := self makeUnsignedFrom: 
		((self cCoerce: bits to:'int*') at: (bmRaster * yp) + (xp >> rShift)).
	"cMask - mask out the pixel from the word"
	cMask := (1 << bmDepth) - 1.
	"rShift - shift value to move the pixel in the word to the lowest bit position"
	rShift := 32 - bmDepth - ((xp bitAnd: (1 << rShift - 1)) * bmDepth).
	value := (value >> rShift) bitAnd: cMask.
	bmDepth = 16 ifTrue: [
		"Must convert by expanding bits"
		value = 0 ifFalse: [
			b := (value bitAnd: 31) << 3.		b := b + (b >> 5).
			g := (value >> 5 bitAnd: 31) << 3.	g := g + (g >> 5).
			r := (value >> 10 bitAnd: 31) << 3.	r := r + (r >> 5).
			a := 255.
			value := b + (g << 8) + (r << 16) + (a << 24)].
	] ifFalse: [
		"Must convert by using color map"
		(self bitmapCmSizeOf: bmFill) = 0
			ifTrue: [value := 0]
			ifFalse: [value := self makeUnsignedFrom: ((self colormapOf: bmFill) at: value)].
	].
	^self uncheckedTransformColor: value.