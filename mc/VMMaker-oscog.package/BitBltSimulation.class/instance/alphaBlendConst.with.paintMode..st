combination rules
alphaBlendConst: sourceWord with: destinationWord paintMode: paintMode
	"Blend sourceWord with destinationWord using a constant alpha.
	Alpha is encoded as 0 meaning 0.0, and 255 meaning 1.0.
	The blend produced is alpha*source + (1.0-alpha)*dest, with the
	computation being performed independently on each color component.
	This function could eventually blend into any depth destination,
	using the same color averaging and mapping as warpBlt.
	paintMode = true means do nothing if the source pixel value is zero."

	"This first implementation works with dest depths of 16 and 32 bits only.
	Normal color mapping will allow sources of lower depths in this case,
	and results can be mapped directly by truncation, so no extra color maps are needed.
	To allow storing into any depth will require subsequent addition of two other
	colormaps, as is the case with WarpBlt."

	| pixMask destShifted sourceShifted destPixVal rgbMask sourcePixVal unAlpha result pixBlend shift blend maskShifted bitsPerColor |
	<inline: false>
	destDepth < 16 ifTrue: [^ destinationWord "no-op"].
	unAlpha := 255 - sourceAlpha.
	pixMask := maskTable at: destDepth.
	destDepth = 16 
		ifTrue: [bitsPerColor := 5]
		ifFalse:[bitsPerColor := 8].
	rgbMask := (1<<bitsPerColor) - 1.
	maskShifted := destMask.
	destShifted := destinationWord.
	sourceShifted := sourceWord.
	result := destinationWord.
	destPPW = 1 ifTrue:["32bpp blends include alpha"
		paintMode & (sourceWord = 0)  "painting a transparent pixel" ifFalse:[
			result := 0.
			1 to: 4 do:[:i|
				shift := (i-1)*8.
				blend := (((sourceWord>>shift bitAnd: rgbMask) * sourceAlpha)
							+ ((destinationWord>>shift bitAnd: rgbMask) * unAlpha))
					 	+ 254 // 255 bitAnd: rgbMask.
				result := result bitOr: blend<<shift].
		].
	] ifFalse:[
		1 to: destPPW do:[:j |
			sourcePixVal := sourceShifted bitAnd: pixMask.
			((maskShifted bitAnd: pixMask) = 0  "no effect if outside of dest rectangle"
				or: [paintMode & (sourcePixVal = 0)  "or painting a transparent pixel"])
			ifFalse:
				[destPixVal := destShifted bitAnd: pixMask.
				pixBlend := 0.
				1 to: 3 do:
					[:i | shift := (i-1)*bitsPerColor.
					blend := (((sourcePixVal>>shift bitAnd: rgbMask) * sourceAlpha)
								+ ((destPixVal>>shift bitAnd: rgbMask) * unAlpha))
						 	+ 254 // 255 bitAnd: rgbMask.
					pixBlend := pixBlend bitOr: blend<<shift].
				destDepth = 16
					ifTrue: [result := (result bitAnd: (pixMask << (j-1*16)) bitInvert32)
										bitOr: pixBlend << (j-1*16)]
					ifFalse: [result := pixBlend]].
			maskShifted := maskShifted >> destDepth.
			sourceShifted := sourceShifted >> destDepth.
			destShifted := destShifted >> destDepth].
	].
	^ result
