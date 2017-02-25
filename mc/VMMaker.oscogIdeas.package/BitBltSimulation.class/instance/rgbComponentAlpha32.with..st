combination rules
rgbComponentAlpha32: sourceWord with: destinationWord
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
	| alpha dstMask srcColor srcAlpha b g r a aB aG aR aA answer s d |
		
	alpha := sourceWord.
	alpha = 0 ifTrue:[^destinationWord].
	srcColor := componentAlphaModeColor.
	srcAlpha := componentAlphaModeAlpha bitAnd: 255.
	
	aB := alpha bitAnd: 255.
	alpha := alpha >> 8.
	aG := alpha bitAnd: 255.
	alpha := alpha >> 8.
	aR := alpha bitAnd: 255.
	alpha := alpha >> 8.
	aA := alpha bitAnd: 255.	

	srcAlpha = 255 
		ifFalse:[
			aA := aA * srcAlpha >> 8.
			aR := aR * srcAlpha >> 8.
			aG := aG * srcAlpha >> 8.
			aB := aB * srcAlpha >> 8].
			
	dstMask := destinationWord.
	d := dstMask bitAnd: 255.
	s := srcColor bitAnd: 255.
	ungammaLookupTable == nil
		ifFalse:[
			d := ungammaLookupTable at: d.
			s := ungammaLookupTable at: s.].
	b := (d * (255 - aB) >> 8) + (s * aB >> 8).
	b > 255 ifTrue:[b := 255].
	gammaLookupTable == nil
		ifFalse:[	
			b := gammaLookupTable at: b].
	dstMask := dstMask >> 8.
	srcColor := srcColor >> 8.
	d := dstMask bitAnd: 255.
	s := srcColor bitAnd: 255.
	ungammaLookupTable == nil
		ifFalse:[
			d := ungammaLookupTable at: d.
			s := ungammaLookupTable at: s.].
	g := (d * (255 - aG) >> 8) + (s * aG >> 8).
	g > 255 ifTrue:[g := 255].
	gammaLookupTable == nil
		ifFalse:[	
			g := gammaLookupTable at: g].
	dstMask := dstMask >> 8.
	srcColor := srcColor >> 8.
	d := dstMask bitAnd: 255.
	s := srcColor bitAnd: 255.
	ungammaLookupTable == nil
		ifFalse:[
			d := ungammaLookupTable at: d.
			s := ungammaLookupTable at: s.].
	r := (d * (255 - aR) >> 8) + (s * aR >> 8).
	r > 255 ifTrue:[r := 255].
	gammaLookupTable == nil
		ifFalse:[	
			r := gammaLookupTable at: r].
	dstMask := dstMask >> 8.
	srcColor := srcColor >> 8.
	a := ((dstMask bitAnd: 255) * (255 - aA) >> 8) + aA. "no need to gamma correct alpha value ?"
	a > 255 ifTrue:[a := 255].
	answer := (((((a << 8) + r) << 8) + g) << 8) + b.
	^answer	