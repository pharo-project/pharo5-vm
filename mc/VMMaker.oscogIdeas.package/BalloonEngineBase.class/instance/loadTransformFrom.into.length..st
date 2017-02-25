loading state
loadTransformFrom: transformOop into: destPtr length: n
	"Load a transformation from transformOop into the float array
	defined by destPtr. The transformation is assumed to be either
	an array or a FloatArray of length n."
	<inline: false>
	<var: #destPtr type:'float *'>
	transformOop = interpreterProxy nilObject ifTrue:[^false].
	(interpreterProxy isImmediate: transformOop)
		ifTrue:[^interpreterProxy primitiveFail].
	(interpreterProxy slotSizeOf: transformOop) = n 
		ifFalse:[^interpreterProxy primitiveFail].
	(interpreterProxy isWords: transformOop) 
		ifTrue:[self loadWordTransformFrom: transformOop into: destPtr length: n]
		ifFalse:[self loadArrayTransformFrom: transformOop into: destPtr length: n].
	^true