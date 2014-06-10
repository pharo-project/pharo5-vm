transforms
primitiveAdj3
	"Computes the adjoint of the Matrix4x4 receiver,
	placing the results the the Matrix4x4 argument,
	"
	| 	
		argc 
		srcOop src 
		dstOop dst
		m11 m12 m13 m21 m22 m23 m31 m32 m33 
		c11 c12 c13 c21 c22 c23 c31 c32 c33 
		  
	|
	<export: true>
	<inline: true>
	<var: #c11 declareC: 'const int c11 = 0'>
	<var: #c12 declareC: 'const int c12 = 1'>
	<var: #c13 declareC: 'const int c13 = 2'>
	"<var: #c14 declareC: 'const int c14 = 3'>"
	<var: #c21 declareC: 'const int c21 = 4'>
	<var: #c22 declareC: 'const int c22 = 5'>
	<var: #c23 declareC: 'const int c23 = 6'>
	"<var: #c24 declareC: 'const int c24 = 7'>"
	<var: #c31 declareC: 'const int c31 = 8'>
	<var: #c32 declareC: 'const int c32 = 9'>
	<var: #c33 declareC: 'const int c33 = 10'>
	"<var: #c34 declareC: 'const int c34 = 11'>"
	<var: #src type: 'float *'>
	<var: #dst type: 'float *'>
	<var: #m11 type:  'double'>
	<var: #m12 type:  'double'>
	<var: #m13 type:  'double'>
	<var: #m21 type:  'double'>
	<var: #m22 type:  'double'>
	<var: #m23 type:  'double'>
	<var: #m31 type:  'double'>
	<var: #m32 type:  'double'>
	<var: #m33 type:  'double'>

	"then we need the following no-op to make Smalltalk shut up about vars not being initted."
	self cCode: '' inSmalltalk: [ 
		c11 := 0. 
		c12 := 1.
		c13 := 2.
		"c14 := 3."
		c21 := 4.
		c22 := 5.
		c23 := 6.
		"c24 := 7."
		c31 := 8.
		c32 := 9.
		c33 := 10.
		"c34 := 11."
	].

	"NOTE: the bottom row of a OpenGL-ordered matrix is always 0 0 0 1, 
	so we don't need consts here for those elements."

	"do the dance to get our receiver and argument"
	argc := interpreterProxy methodArgumentCount.
	argc = 1
		ifFalse:[^interpreterProxy primitiveFail].

	"stackArgvObject is something I added to Interpreter, but since it's not in there yet,
	this won't compile - use it when it's there.  Yes, it would be nice if Smalltalk had #ifdefs..."
	self flag: #stackArgv.
"
	srcOop := interpreterProxy stackArgvObject: 0.	
	src := interpreterProxy firstIndexableField: srcOop.

	dstOop := interpreterProxy stackArgvObject: 1.
	dst := interpreterProxy firstIndexableField: dstOop.
"
	srcOop := interpreterProxy stackObjectValue: argc.	
	src := interpreterProxy firstIndexableField: srcOop.

	dstOop := interpreterProxy stackObjectValue: (argc - 1).
	dst := interpreterProxy firstIndexableField: dstOop.


	"read in the source matrix 3x3, which contains the encoded rotation and scale factors"
	m11 := src at: c11.
	m12 := src at: c12.
	m13 := src at: c13.
	m21 := src at: c21.
	m22 := src at: c22.
	m23 := src at: c23.
	m31 := src at: c31.
	m32 := src at: c32.
	m33 := src at: c33.

	"do the actual work"

	"compute our cofactors and transpose.  adj = transpose of cofactors"
	dst at: c11 put:  ((m22 * m33) - (m23 *  m32)) .
	dst at: c21 put: (0.0 - ((m21 * m33) - (m23 * m31))).
	dst at: c31 put: ((m21 * m32) - (m22 * m31)).

	dst at: c12 put: (0.0 - ((m12 * m33) - (m13 * m32))).
	dst at: c22 put: ((m11 * m33) - (m13 * m31)).
	dst at: c32 put: (0.0 - ((m11 * m32) - (m12 * m31))).

	dst at: c13 put: ((m12 * m23) - (m13 * m22)).
	dst at: c23 put: (0.0 - ((m11 * m23) - (m13 * m21))).
	dst at: c33 put: ((m11 * m22) - (m12 * m21)).
	
	interpreterProxy pop: argc + 1 thenPush: dstOop
