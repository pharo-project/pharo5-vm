combination rules
alphaBlend: sourceWord with: destinationWord
	"Blend sourceWord with destinationWord, assuming both are 32-bit pixels.
	The source is assumed to have 255*alpha in the high 8 bits of each pixel,
	while the high 8 bits of the destinationWord will be ignored.
	The blend produced is alpha*source + (1-alpha)*dest, with
	the computation being performed independently on each color
	component.  The high byte of the result will be 0."
	| alpha unAlpha colorMask result blend shift |
	<inline: false>
	alpha := sourceWord >> 24.  "High 8 bits of source pixel"
	alpha = 0 ifTrue: [ ^ destinationWord ].
	alpha = 255 ifTrue: [ ^ sourceWord ].
	unAlpha := 255 - alpha.
	colorMask := 16rFF.
	result := 0.

	"red"
	shift := 0.
	blend := ((sourceWord >> shift bitAnd: colorMask) * alpha) +
				((destinationWord>>shift bitAnd: colorMask) * unAlpha)
			 	+ 254 // 255 bitAnd: colorMask.
	result := result bitOr: blend << shift.
	"green"
	shift := 8.
	blend := ((sourceWord >> shift bitAnd: colorMask) * alpha) +
				((destinationWord>>shift bitAnd: colorMask) * unAlpha)
			 	+ 254 // 255 bitAnd: colorMask.
	result := result bitOr: blend << shift.
	"blue"
	shift := 16.
	blend := ((sourceWord >> shift bitAnd: colorMask) * alpha) +
				((destinationWord>>shift bitAnd: colorMask) * unAlpha)
			 	+ 254 // 255 bitAnd: colorMask.
	result := result bitOr: blend << shift.
	"alpha (pre-multiplied)"
	shift := 24.
	blend := (alpha * 255) +
				((destinationWord>>shift bitAnd: colorMask) * unAlpha)
			 	+ 254 // 255 bitAnd: colorMask.
	result := result bitOr: blend << shift.
	^ result
