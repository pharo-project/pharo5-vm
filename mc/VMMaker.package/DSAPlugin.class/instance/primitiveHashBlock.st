primitives-SHA
primitiveHashBlock
	"Hash a Bitmap of 80 32-bit words (the first argument), using the given state (the second argument)."

	| state buf statePtr bufPtr a b c d e tmp |
	<export: true>
	<var: #statePtr type: 'unsigned int *'>
	<var: #bufPtr type: 'unsigned int *'>

	state := interpreterProxy stackObjectValue: 0.
	buf := interpreterProxy stackObjectValue: 1.
	interpreterProxy success: (interpreterProxy isWords: state).
	interpreterProxy success: (interpreterProxy isWords: buf).
	interpreterProxy failed ifTrue: [^ nil].

	interpreterProxy success: ((interpreterProxy stSizeOf: state) = 5).
	interpreterProxy success: ((interpreterProxy stSizeOf: buf) = 80).
	interpreterProxy failed ifTrue: [^ nil].

	statePtr := interpreterProxy firstIndexableField: state.
	bufPtr := interpreterProxy firstIndexableField: buf.

	a := statePtr at: 0.
	b := statePtr at: 1.
	c := statePtr at: 2.
	d := statePtr at: 3.
	e := statePtr at: 4.
 
	0 to: 19 do: [:i |
		tmp := 16r5A827999 + ((b bitAnd: c) bitOr: (b bitInvert32 bitAnd: d)) +
				(self leftRotate: a by: 5) +  e + (bufPtr at: i).
		e := d.  d := c.  c := self leftRotate: b by: 30.  b := a.  a := tmp].

	20 to: 39 do: [:i |
		tmp := 16r6ED9EBA1 + ((b bitXor: c) bitXor: d) +
				(self leftRotate: a by: 5) +  e + (bufPtr at: i).
		e := d.  d := c.  c := self leftRotate: b by: 30.  b := a.  a := tmp].

	40 to: 59 do: [:i |
		tmp := 16r8F1BBCDC + (((b bitAnd: c) bitOr: (b bitAnd: d)) bitOr: (c bitAnd: d)) +
				(self leftRotate: a by: 5) +  e + (bufPtr at: i).
		e := d.  d := c.  c := self leftRotate: b by: 30.  b := a.  a := tmp].

	60 to: 79 do: [:i |
		tmp := 16rCA62C1D6 + ((b bitXor: c) bitXor: d) +
				(self leftRotate: a by: 5) +  e + (bufPtr at: i).
		e := d.  d := c.  c := self leftRotate: b by: 30.  b := a.  a := tmp].

	statePtr at: 0 put: (statePtr at: 0) + a.
	statePtr at: 1 put: (statePtr at: 1) + b.
	statePtr at: 2 put: (statePtr at: 2) + c.
	statePtr at: 3 put: (statePtr at: 3) + d.
	statePtr at: 4 put: (statePtr at: 4) + e.

	interpreterProxy pop: 2.
