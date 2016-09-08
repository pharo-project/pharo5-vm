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

	| pixMask destShifted sourceShifted destPixVal rgbMask sourcePixVal unAlpha result pixBlend shift blend maskShifted bitsPerColor blendAG blendRB |
	<inline: false>
	<returnTypeC: 'unsigned int'>
	<var: #sourceWord type: 'unsigned int'>
	<var: #destinationWord type: 'unsigned int'>
	<var: #blendRB type: 'unsigned int'>
	<var: #blendAG type: 'unsigned int'>
	<var: #result type: 'unsigned int'>
	<var: #sourceAlpha type: 'unsigned int'>
	<var: #unAlpha type: 'unsigned int'>
	<var: #sourceShifted type: 'unsigned int'>
	<var: #destShifted type: 'unsigned int'>
	<var: #maskShifted type: 'unsigned int'>
	<var: #pixMask type: 'unsigned int'>
	<var: #rgbMask type: 'unsigned int'>
	<var: #pixBlend type: 'unsigned int'>
	<var: #blend type: 'unsigned int'>
	destDepth < 16 ifTrue: [^ destinationWord "no-op"].
	unAlpha := 255 - sourceAlpha.
	result := destinationWord.
	destPPW = 1 ifTrue:["32bpp blends include alpha"
		paintMode & (sourceWord = 0)  "painting a transparent pixel" ifFalse:[

				blendRB := ((sourceWord bitAnd: 16rFF00FF) * sourceAlpha) +
						((destinationWord bitAnd: 16rFF00FF) * unAlpha) + 16rFF00FF.	"blendRB red and blue"

				blendAG := ((sourceWord>> 8 bitAnd: 16rFF00FF) * sourceAlpha) +
						((destinationWord>>8 bitAnd: 16rFF00FF) * unAlpha) + 16rFF00FF.	"blendRB alpha and green"

				blendRB := blendRB + (blendRB - 16r10001 >> 8 bitAnd: 16rFF00FF) >> 8 bitAnd: 16rFF00FF.	"divide by 255"
				blendAG := blendAG + (blendAG - 16r10001 >> 8 bitAnd: 16rFF00FF) >> 8 bitAnd: 16rFF00FF.
				result := blendRB bitOr: blendAG<<8.
		].
	] ifFalse:[
		pixMask := maskTable at: destDepth.
		bitsPerColor := 5.
		rgbMask := 16r1F.
		maskShifted := destMask.
		destShifted := destinationWord.
		sourceShifted := sourceWord.
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
				result := (result bitAnd: (pixMask << (j-1*16)) bitInvert32)
								bitOr: pixBlend << (j-1*16)].
			maskShifted := maskShifted >> destDepth.
			sourceShifted := sourceShifted >> destDepth.
			destShifted := destShifted >> destDepth].
	].
	^ result
