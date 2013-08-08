instance creation
exponentialDecay: multiplier
	"(Envelope exponentialDecay: 0.95) "

	| mSecsPerStep pList t v last |
	mSecsPerStep := 10.
	((multiplier > 0.0) and: [multiplier < 1.0])
		ifFalse: [self error: 'multiplier must be greater than 0.0 and less than 1.0'].
	pList := OrderedCollection new.
	pList add: 0@0.0.
	last := 0.0.
	v := 1.0.
	t := 10.
	[v > 0.01] whileTrue: [
		(v - last) abs > 0.02 ifTrue: [
			"only record substatial changes"
			pList add: t@v.
			last := v].
		t := t + mSecsPerStep.
		v := v * multiplier].
	pList add: (t + mSecsPerStep)@0.0.

	^ self points: pList asArray
		loopStart: pList size 
		loopEnd: pList size
