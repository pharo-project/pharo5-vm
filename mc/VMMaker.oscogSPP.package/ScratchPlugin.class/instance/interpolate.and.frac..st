private
interpolate: pix1 and: pix2 frac: frac2
	"Answer the interpolated pixel value between the given two pixel values. If either pixel is zero (transparent) answer the other pixel. If both pixels are  transparent, answer transparent. The fraction is between 0 and 1023, out of a total range of 1024."

	| frac1 r g b result |
	<inline: true>

	pix1 = 0 ifTrue: [^ pix2].  "pix1 is transparent"
	pix2 = 0 ifTrue: [^ pix1].  "pix2 is transparent"

	frac1 := 1024 - frac2.
	r := ((frac1 * ((pix1 bitShift: -16) bitAnd: 16rFF)) + (frac2 * ((pix2 bitShift: -16) bitAnd: 16rFF))) // 1024.
	g := ((frac1 * ((pix1 bitShift: -8) bitAnd: 16rFF)) + (frac2 * ((pix2 bitShift: -8) bitAnd: 16rFF))) // 1024.
	b := ((frac1 * (pix1 bitAnd: 16rFF)) + (frac2 * (pix2 bitAnd: 16rFF))) // 1024.
	result := (r bitShift: 16) + (g bitShift: 8) + b.
	result = 0 ifTrue: [result := 1].
	^ result
