transforms
primitiveDet3
	"Computes the determinant of the upper 3x3 of a Matrix4x4"
	| argc  srcOop src det m11 m12 m13 m21 m22 m23 m31 m32 m33 |
	<export: true>
	<inline: true>
	<var: #src type: 'float *'>
	<var: #m11 type:  'double'>
	<var: #m12 type:  'double'>
	<var: #m13 type:  'double'>
	<var: #m21 type:  'double'>
	<var: #m22 type:  'double'>
	<var: #m23 type:  'double'>
	<var: #m31 type:  'double'>
	<var: #m32 type:  'double'>
	<var: #m33 type:  'double'>
	<var: #det type: 'double'>

	argc := interpreterProxy methodArgumentCount.
	argc = 0
		ifFalse:[^interpreterProxy primitiveFail].


	"
		Load element vars using C version of Matrix4x4 storage, as 0-based, 1-dimensional array:
			0 1 2 3
			4 5 6 7
			8 9 10 11
	"

	"stackArgvObject is something I added to Interpreter, but since it's not in there yet,
	this won't compile - use it when it's there.  Yes, it would be nice if Smalltalk had #ifdefs..."
	self flag: #stackArgv.
"
	srcOop := interpreterProxy stackArgvObject: 0.	
	src := interpreterProxy firstIndexableField: srcOop.
"
	srcOop := interpreterProxy stackObjectValue: argc.	
	src := interpreterProxy firstIndexableField: srcOop.


	m11 := src at: 0.
	m12 := src at: 1.
	m13 := src at: 2.
	m21 := src at: 4.
	m22 := src at: 5.
	m23 := src at: 6.
	m31 := src at: 8.
	m32 := src at: 9.
	m33 := src at: 10.


	"do the actual work"
	det := 
		( m11 * ((m22 * m33) - (m23 * m32))) +
			(m12 * ((m23 * m31) - (m21 * m33))) +
				(m13 * ((m21 * m32) - (m22 * m31))).

	
	interpreterProxy pop: argc + 1.
	^interpreterProxy pushFloat: det.
