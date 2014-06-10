fills-gradient
loadGradientFill: rampOop from: point1 along: point2 normal: point3 isRadial: isRadial
	"Load the gradient fill as defined by the color ramp."
	| rampWidth fill |
	<inline: false>
	<var: #point1 type:'int *'>
	<var: #point2 type:'int *'>
	<var: #point3 type:'int *'>
	(interpreterProxy fetchClassOf: rampOop) = interpreterProxy classBitmap
		ifFalse:[^interpreterProxy primitiveFail].
	rampWidth := interpreterProxy slotSizeOf: rampOop.
	fill := self allocateGradientFill: (interpreterProxy firstIndexableField: rampOop)
				rampWidth: rampWidth isRadial: isRadial.
	engineStopped ifTrue:[^nil].
	self loadFillOrientation: fill 
		from: point1 along: point2 normal: point3 
		width: rampWidth height: rampWidth.
	^fill