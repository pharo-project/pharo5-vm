other filters
primitiveWaterRipples1
 
	| in out aArray bArray ripply temp pix dx dy dist inOop outOop width allPix aArOop bArOop height t1 blops x y power val val2 dx2 dy2 newLoc |
	<export: true>
	<var: 'in' declareC: 'unsigned int *in'>
	<var: 'out' declareC: 'unsigned int *out'>
	<var: 'aArray' declareC: 'double *aArray'>
	<var: 'bArray' declareC: 'double *bArray'>
	<var: 'ripply' declareC: 'int ripply'>
	<var: 'temp' declareC: 'double temp'>
	<var: 'pix' declareC: 'unsigned int pix'>
	<var: 'dist' declareC: 'double dist'>
	<var: 'dx2' declareC: 'double dx2'>
	<var: 'dy2' declareC: 'double dy2'>

	inOop := interpreterProxy stackValue: 5.
	outOop := interpreterProxy stackValue: 4.
	width := interpreterProxy stackIntegerValue: 3.
	in := self checkedUnsignedIntPtrOf: inOop.
	out := self checkedUnsignedIntPtrOf: outOop.
	allPix := interpreterProxy stSizeOf: inOop.
	ripply := interpreterProxy stackIntegerValue: 2.
	aArOop := interpreterProxy stackValue: 1.
	bArOop := interpreterProxy stackValue: 0.
	aArray := self checkedFloatPtrOf: aArOop.
	bArray := self checkedFloatPtrOf: bArOop.
	interpreterProxy success: ((interpreterProxy stSizeOf: outOop) = allPix).
	interpreterProxy failed ifTrue: [^ nil].

	height := allPix // width.

	t1 := self cCode: 'rand()'.
	blops := t1 \\ ripply -1.
	0 to: blops /2-1 do: [:t |
		t1 := self cCode: 'rand()'.
		x := t1 \\ width.
		t1 := self cCode: 'rand()'.
		y := t1 \\ height.
		t1 := self cCode: 'rand()'.
		power := t1 \\ 8.
		-4 to: 4 do: [:g |
			-4 to: 4 do: [:h |
				dist := ((g*g) + (h*h)) asFloat.
				((dist < 25) and: [dist > 0]) ifTrue: [
						dx := (x + g) asInteger.
						dy := (y + h) asInteger.
						((dx >0) and: [(dy>0) and: [(dy < height) and: [dx < width]]]) ifTrue: [
							aArray at: ((dy)*width + dx) put: (power *(1.0 asFloat -(dist/(25.0 asFloat))) asFloat).
						].
					].
				].
			].
		].
	
		1 to: width -2 do: [:f |
			1 to: height -2 do: [:d |
			val := (d)*width + f.
			aArray at: val put: (((
				(bArray at: (val+1)) + (bArray at: (val-1)) + (bArray at: (val + width)) + (bArray at: (val - width)) +
				((bArray at: (val -1 -width))/2) + ((bArray at: (val-1+width))/2) + ((bArray at: (val+1-width))/2) + ((bArray at: (val+1+width))/2)) /4) - (aArray at: (val))).
			aArray at: (val) put: ((aArray at: (val))*(0.9 asFloat)).
			].
		].
	
		"temp := bArray.
		bArray := aArray.
		aArray := temp."
		0 to: width*height do: [:q |
			temp := bArray at: q.
			bArray at: q put: (aArray at: q).
			aArray at: q put: temp.
		].

		0 to: height-1 do: [:j |
			0 to: width-1 do: [:i |
				((i > 1) and: [(i<(width-1)) and: [(j>1) and: [(j<(height-1))]]]) ifTrue: [
					val2 := (j)*width + i.
					dx2 := ((((aArray at: (val2)) - (aArray at: (val2-1))) + ((aArray at: (val2+1)) - (aArray at: (val2)))) *64) asFloat.
					dy2 := ((((aArray at: (val2)) - (aArray at: (val2-width))) + ((aArray at: (val2+width)) - (aArray at: (val2)))) /64) asFloat.
					(dx2 < -2) ifTrue: [dx2 := -2].
					(dx2 >  2) ifTrue: [dx2 :=  2].
					(dy2 < -2) ifTrue: [dy2 := -2].
					(dy2 >  2) ifTrue: [dy2 :=  2].
					newLoc := ((j+dy2)*width + (i+dx2)) asInteger.
					((newLoc < (width*height)) and: [newLoc >=0]) ifTrue: [
						pix := in at: newLoc]
					ifFalse: [
						pix := in at: (i +(j*width)) ].
				]
				ifFalse: [
					pix := in at: (i +(j*width)) ].
			out at: (i + (j*width)) put: pix.
		]].

	interpreterProxy pop: 6.  "pop args, leave rcvr on stack"
	^ 0
