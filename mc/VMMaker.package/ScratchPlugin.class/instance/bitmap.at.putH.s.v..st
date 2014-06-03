private
bitmap: bitmap at: i putH: hue s: saturation v: brightness

	| hI hF p q t v outPix |
	<inline: true>
	<var: 'bitmap' declareC: 'unsigned int *bitmap'>

	hI := hue // 60.  "integer part of hue (0..5)"
	hF := hue \\ 60.  "fractional part ofhue"
	p := (1000 - saturation) * brightness.
	q := (1000 - ((saturation * hF) // 60)) * brightness.
	t := (1000 - ((saturation * (60 - hF)) // 60)) * brightness.

	v := (brightness * 1000) // 3922.
	p := p // 3922.
	q := q // 3922.
	t := t // 3922.

	0 = hI ifTrue: [outPix := ((v bitShift: 16) + (t bitShift: 8) + p)].
	1 = hI ifTrue: [outPix := ((q bitShift: 16) + (v bitShift: 8) + p)].
	2 = hI ifTrue: [outPix := ((p bitShift: 16) + (v bitShift: 8) + t)].
	3 = hI ifTrue: [outPix := ((p bitShift: 16) + (q bitShift: 8) + v)].
	4 = hI ifTrue: [outPix := ((t bitShift: 16) + (p bitShift: 8) + v)].
	5 = hI ifTrue: [outPix := ((v bitShift: 16) + (p bitShift: 8) + q)].

	outPix = 0 ifTrue: [outPix := 1].  "convert transparent to 1"
	bitmap at: i put: outPix.
	^ 0
