fills-bitmaps
fillBitmapSpan: bmFill from: leftX to: rightX at: yValue
	| x x1 dsX ds dtX dt deltaX deltaY bits xp yp bmWidth bmHeight fillValue tileFlag |
	<inline: false>
	<var: #bits type:'int *'>
	self aaLevelGet = 1
		ifFalse:[^self fillBitmapSpanAA: bmFill from: leftX to: rightX at: yValue].

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

	x := leftX.
	x1 := rightX.
	[x < x1] whileTrue:[
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
			spanBuffer at: x put: fillValue.
		].
		ds := ds + dsX.
		dt := dt + dtX.
		x := x + 1.
	].