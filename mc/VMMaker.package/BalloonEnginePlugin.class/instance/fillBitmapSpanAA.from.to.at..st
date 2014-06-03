fills-bitmaps
fillBitmapSpanAA: bmFill from: leftX to: rightX at: yValue
	| x dsX ds dtX dt deltaX deltaY bits xp yp bmWidth bmHeight fillValue baseShift cMask cShift idx aaLevel firstPixel lastPixel tileFlag |
	<inline: false>
	<var: #bits type:'int *'>
	bits := self loadBitsFrom: bmFill.
	bits == nil ifTrue:[^nil].
	bmWidth := self bitmapWidthOf: bmFill.
	bmHeight := self bitmapHeightOf: bmFill.
	tileFlag := (self bitmapTileFlagOf: bmFill) = 1.
	deltaX := leftX - (self fillOriginXOf: bmFill).
	deltaY := yValue - (self fillOriginYOf: bmFill).
	dsX := self fillDirectionXOf: bmFill.
	dtX := self fillNormalXOf: bmFill.

	ds := (deltaX * dsX) + (deltaY * (self fillDirectionYOf: bmFill)).
	dt := (deltaX * dtX) + (deltaY * (self fillNormalYOf: bmFill)).

	aaLevel := self aaLevelGet.
	firstPixel := self aaFirstPixelFrom: leftX to: rightX.
	lastPixel := self aaLastPixelFrom: leftX to: rightX.
	baseShift := self aaShiftGet.
	cMask := self aaColorMaskGet.
	cShift := self aaColorShiftGet.
	x := leftX.
	[x < firstPixel] whileTrue:[
		tileFlag ifTrue:[
			ds := self repeatValue: ds max: bmWidth << 16.
			dt := self repeatValue: dt max: bmHeight << 16].
		xp := ds // 16r10000.
		yp := dt // 16r10000.
		tileFlag ifFalse:[
			xp := self clampValue: xp max: bmWidth.
			yp := self clampValue: yp max: bmHeight].
		(xp >= 0 and:[yp >= 0 and:[xp < bmWidth and:[yp < bmHeight]]]) ifTrue:[
			fillValue := self bitmapValue: bmFill bits: bits atX: xp y: yp.
			fillValue := (fillValue bitAnd: cMask) >> cShift.
			idx := x >> baseShift.
			spanBuffer at: idx put: (spanBuffer at: idx) + fillValue.
		].
		ds := ds + dsX.
		dt := dt + dtX.
		x := x + 1.
	].

	cMask := (self aaColorMaskGet >> self aaShiftGet) bitOr: 16rF0F0F0F0.
	cShift := self aaShiftGet.
	[x < lastPixel] whileTrue:[
		tileFlag ifTrue:[
			ds := self repeatValue: ds max: bmWidth << 16.
			dt := self repeatValue: dt max: bmHeight << 16].
		xp := ds // 16r10000.
		yp := dt // 16r10000.
		tileFlag ifFalse:[
			xp := self clampValue: xp max: bmWidth.
			yp := self clampValue: yp max: bmHeight].
		(xp >= 0 and:[yp >= 0 and:[xp < bmWidth and:[yp < bmHeight]]]) ifTrue:[
			fillValue := self bitmapValue: bmFill bits: bits atX: xp y: yp.
			fillValue := (fillValue bitAnd: cMask) >> cShift.
			idx := x >> baseShift.
			spanBuffer at: idx put: (spanBuffer at: idx) + fillValue.
		].
		ds := ds + (dsX << cShift).
		dt := dt + (dtX << cShift).
		x := x + aaLevel.
	].

	cMask := self aaColorMaskGet.
	cShift := self aaColorShiftGet.
	[x < rightX] whileTrue:[
		tileFlag ifTrue:[
			ds := self repeatValue: ds max: bmWidth << 16.
			dt := self repeatValue: dt max: bmHeight << 16].
		xp := ds // 16r10000.
		yp := dt // 16r10000.
		tileFlag ifFalse:[
			xp := self clampValue: xp max: bmWidth.
			yp := self clampValue: yp max: bmHeight].
		(xp >= 0 and:[yp >= 0 and:[xp < bmWidth and:[yp < bmHeight]]]) ifTrue:[
			fillValue := self bitmapValue: bmFill bits: bits atX: xp y: yp.
			fillValue := (fillValue bitAnd: cMask) >> cShift.
			idx := x >> baseShift.
			spanBuffer at: idx put: (spanBuffer at: idx) + fillValue.
		].
		ds := ds + dsX.
		dt := dt + dtX.
		x := x + 1.
	].
