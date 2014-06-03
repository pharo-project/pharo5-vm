fills-gradient
fillRadialGradient: fill from: leftX to: rightX at: yValue
	"Draw a radial gradient fill."
	| x x1 ramp rampSize dsX ds dtX dt length2 deltaX deltaY deltaST |
	<inline: false>
	<var: #ramp type:'int *'>
	<var: #deltaST type:'int *'>

	ramp := self gradientRampOf: fill.
	rampSize := self gradientRampLengthOf: fill.

	deltaX := leftX - (self fillOriginXOf: fill).
	deltaY := yValue - (self fillOriginYOf: fill).

	dsX := self fillDirectionXOf: fill.
	dtX := self fillNormalXOf: fill.

	ds := (deltaX * dsX) + (deltaY * (self fillDirectionYOf: fill)).
	dt := (deltaX * dtX) + (deltaY * (self fillNormalYOf: fill)).

	x := leftX.
	x1 := rightX.

	"Note: The inner loop has been divided into three parts for speed"
	"Part one: Fill everything outside the left boundary"
	length2 := (rampSize-1) * (rampSize-1). "This is the upper bound"
	[(self squaredLengthOf: ds // 16r10000 with: dt // 16r10000) >= length2 and:[x < x1]]
		whileTrue:[	x := x + 1.	ds := ds + dsX.	dt := dt + dtX].
	x > leftX ifTrue:[self fillColorSpan: (self makeUnsignedFrom: (ramp at: rampSize-1)) from: leftX to: x].

	"Part two: Fill everything inside the boundaries"
	deltaST := self point1Get.
	deltaST at: 0 put: ds.
	deltaST at: 1 put: dt.
	(x < (self fillOriginXOf: fill)) ifTrue:[
		"Draw the decreasing part"
		self aaLevelGet = 1 
			ifTrue:[x := self fillRadialDecreasing: fill ramp: ramp deltaST: deltaST 
							dsX: dsX dtX: dtX from: x to: x1]
			ifFalse:[x := self fillRadialDecreasingAA: fill ramp: ramp deltaST: deltaST 
							dsX: dsX dtX: dtX from: x to: x1].
	].
	x < x1 ifTrue:[
		"Draw the increasing part"
		self aaLevelGet = 1
			ifTrue:[x := self fillRadialIncreasing: fill ramp: ramp deltaST: deltaST
							dsX: dsX dtX: dtX from: x to: x1]
			ifFalse:[x := self fillRadialIncreasingAA: fill ramp: ramp deltaST: deltaST
							dsX: dsX dtX: dtX from: x to: x1].
	].

	"Part three fill everything outside right boundary"
	x < rightX ifTrue:[self fillColorSpan: (self makeUnsignedFrom: (ramp at: rampSize-1)) from: x to: rightX].
