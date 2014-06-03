transforming
transformWidth: w
	"Transform the given width"
	| deltaX deltaY dstWidth dstWidth2 |
	<inline: false>
	<var: #deltaX type:'double '>
	<var: #deltaY type:'double '>
	w = 0 ifTrue:[^0].
	self point1Get at: 0 put: 0.
	self point1Get at: 1 put: 0.
	self point2Get at: 0 put: w * 256.
	self point2Get at: 1 put: 0.
	self point3Get at: 0 put: 0.
	self point3Get at: 1 put: w * 256.
	self transformPoints: 3.
	deltaX := ((self point2Get at: 0) - (self point1Get at: 0)) asFloat.
	deltaY := ((self point2Get at: 1) - (self point1Get at: 1)) asFloat.
	dstWidth := (((deltaX * deltaX) + (deltaY * deltaY)) sqrt asInteger + 128) // 256.
	deltaX := ((self point3Get at: 0) - (self point1Get at: 0)) asFloat.
	deltaY := ((self point3Get at: 1) - (self point1Get at: 1)) asFloat.
	dstWidth2 := (((deltaX * deltaX) + (deltaY * deltaY)) sqrt asInteger + 128) // 256.
	dstWidth2 < dstWidth ifTrue:[dstWidth := dstWidth2].
	dstWidth = 0
		ifTrue:[^1]
		ifFalse:[^dstWidth]