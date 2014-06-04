processing-LF
zeroQphi: phi cosphi: cosphi sinphi: sinphi rphid: rphid
	| qzero ua ub qa qb uc qc |
	<returnTypeC: 'float'>
	<var: 'qzero' type: 'float '>
	<var: 'ua' type: 'float '>
	<var: 'ub' type: 'float '>
	<var: 'qa' type: 'float '>
	<var: 'qb' type: 'float '>
	<var: 'uc' type: 'float '>
	<var: 'qc' type: 'float '>
	<var: 'phi' type: 'float '>
	<var: 'cosphi' type: 'float '>
	<var: 'sinphi' type: 'float '>
	<var: 'rphid' type: 'float '>

	qzero := self qu: 0 phi: phi cosphi: cosphi sinphi: sinphi rphid: rphid.

	qzero > 0
		ifTrue: [ua := 0. ub := 1.
				qa := qzero. qb := self qu: ub phi: phi cosphi: cosphi sinphi: sinphi rphid: rphid.
				[qb > 0]
					whileTrue: [ua := ub. qa := qb.
								ub := ub * 2. qb := self qu: ub phi: phi cosphi: cosphi sinphi: sinphi rphid: rphid]]
		ifFalse: [ua := -1. ub := 0.
				qa := self qu: ua phi: phi cosphi: cosphi sinphi: sinphi rphid: rphid. qb := qzero.
				[qa < 0]
					whileTrue: [ub := ua. qb := qa.
								ua := ua * 2. qa := self qu: ua phi: phi cosphi: cosphi sinphi: sinphi rphid: rphid]].
	[ub - ua > Epsilon]
		whileTrue: [uc := ub + ua / 2.0. qc := self qu: uc phi: phi cosphi: cosphi sinphi: sinphi rphid: rphid.
					qc > 0 ifTrue: [ua := uc. qa := qc] ifFalse: [ub := uc. qb := qc]].
	^ ub + ua / 2.0