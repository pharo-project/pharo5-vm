combination rules
alphaBlendScaled: sourceWord with: destinationWord
	"Blend sourceWord with destinationWord using the alpha value from sourceWord.
	Alpha is encoded as 0 meaning 0.0, and 255 meaning 1.0.
	In contrast to alphaBlend:with: the color produced is

		srcColor + (1-srcAlpha) * dstColor

	e.g., it is assumed that the source color is already scaled."
	| unAlpha dstMask srcMask b g r a |
	<inline: false>	"Do NOT inline this into optimized loops"
	unAlpha := 255 - (sourceWord >> 24).  "High 8 bits of source pixel"
	dstMask := destinationWord.
	srcMask := sourceWord.
	b := (dstMask bitAnd: 255) * unAlpha >> 8 + (srcMask bitAnd: 255).
	b > 255 ifTrue:[b := 255].
	dstMask := dstMask >> 8.
	srcMask := srcMask >> 8.
	g := (dstMask bitAnd: 255) * unAlpha >> 8 + (srcMask bitAnd: 255).
	g > 255 ifTrue:[g := 255].
	dstMask := dstMask >> 8.
	srcMask := srcMask >> 8.
	r := (dstMask bitAnd: 255) * unAlpha >> 8 + (srcMask bitAnd: 255).
	r > 255 ifTrue:[r := 255].
	dstMask := dstMask >> 8.
	srcMask := srcMask >> 8.
	a := (dstMask bitAnd: 255) * unAlpha >> 8 + (srcMask bitAnd: 255).
	a > 255 ifTrue:[a := 255].
	^(((((a << 8) + r) << 8) + g) << 8) + b