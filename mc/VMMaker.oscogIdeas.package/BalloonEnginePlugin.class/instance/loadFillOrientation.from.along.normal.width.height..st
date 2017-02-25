fills-gradient
loadFillOrientation: fill from: point1 along: point2 normal: point3 width: fillWidth height: fillHeight
	"Transform the points"
	| dirX dirY nrmX nrmY dsLength2 dsX dsY dtLength2 dtX dtY |
	<var: #point1 type:'int *'>
	<var: #point2 type:'int *'>
	<var: #point3 type:'int *'>

	point2 at: 0 put: (point2 at: 0) + (point1 at: 0).
	point2 at: 1 put: (point2 at: 1) + (point1 at: 1).
	point3 at: 0 put: (point3 at: 0) + (point1 at: 0).
	point3 at: 1 put: (point3 at: 1) + (point1 at: 1).
	self transformPoint: point1.
	self transformPoint: point2.
	self transformPoint: point3.
	dirX := (point2 at: 0) - (point1 at: 0).
	dirY := (point2 at: 1) - (point1 at: 1).
	nrmX := (point3 at: 0) - (point1 at: 0).
	nrmY := (point3 at: 1) - (point1 at: 1).

	"Compute the scale from direction/normal into ramp size"
	dsLength2 := (dirX * dirX) + (dirY * dirY).
	dsLength2 > 0 ifTrue:[
		dsX := (dirX asFloat * fillWidth asFloat * 65536.0 / dsLength2 asFloat) asInteger.
		dsY := (dirY asFloat * fillWidth asFloat * 65536.0 / dsLength2 asFloat) asInteger.
	] ifFalse:[ dsX := 0. dsY := 0].
	dtLength2 := (nrmX * nrmX) + (nrmY * nrmY).
	dtLength2 > 0 ifTrue:[
		dtX := (nrmX asFloat * fillHeight asFloat * 65536.0 / dtLength2 asFloat) asInteger.
		dtY := (nrmY asFloat * fillHeight asFloat * 65536.0 / dtLength2 asFloat) asInteger.
	] ifFalse:[dtX := 0. dtY := 0].
	self fillOriginXOf: fill put: (point1 at: 0).
	self fillOriginYOf: fill put: (point1 at: 1).
	self fillDirectionXOf: fill put: dsX.
	self fillDirectionYOf: fill put: dsY.
	self fillNormalXOf: fill put: dtX.
	self fillNormalYOf: fill put: dtY.
