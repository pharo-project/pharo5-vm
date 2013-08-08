combination rules
rgbComponentAlpha: sourceWord with: destinationWord
	"
	componentAlphaModeColor is the color,
	sourceWord contains an alpha value for each component of RGB
	each of which is encoded as0 meaning 0.0 and 255 meaning 1.0 .
	the rule is...
	
	color = componentAlphaModeColor.
	colorAlpha = componentAlphaModeAlpha.
	mask = sourceWord.
	dst.A =  colorAlpha + (1 - colorAlpha) * dst.A
      dst.R = color.R * mask.R * colorAlpha + (1 - (mask.R * colorAlpha)) * dst.R
      dst.G = color.G * mask.G * colorAlpha + (1 - (mask.G* colorAlpha)) * dst.G
      dst.B = color.B * mask.B * colorAlpha + (1 - (mask.B* colorAlpha)) * dst.B
	"
	<inline: false> "Do NOT inline this into optimized loops"
	| alpha |
		
	alpha := sourceWord.
	alpha = 0 ifTrue:[^destinationWord].
	^self partitionedRgbComponentAlpha: sourceWord dest: destinationWord nBits: destDepth nPartitions: destPPW.