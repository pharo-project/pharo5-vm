primitives-integers
primitiveBigMultiply
	"Multiple f1 by f2, placing the result into prod. f1, f2, and prod must be LargePositiveIntegers, and the length of prod must be the sum of the lengths of f1 and f2."
	"Assume: prod starts out filled with zeros"

	| prod f2 f1 prodLen f1Len f2Len prodPtr f2Ptr f1Ptr digit carry k sum |
	<export: true>
	<var: #prodPtr type: 'unsigned char *'>
	<var: #f2Ptr type: 'unsigned char *'>
	<var: #f1Ptr type: 'unsigned char *'>

	prod := interpreterProxy stackObjectValue: 0.
	f2 := interpreterProxy stackObjectValue: 1.
	f1 := interpreterProxy stackObjectValue: 2.
	interpreterProxy success: (interpreterProxy isBytes: prod).
	interpreterProxy success: (interpreterProxy isBytes: f2).
	interpreterProxy success: (interpreterProxy isBytes: f1).
	interpreterProxy success:
		(interpreterProxy fetchClassOf: prod) = interpreterProxy classLargePositiveInteger.
	interpreterProxy success:
		(interpreterProxy fetchClassOf: f2) = interpreterProxy classLargePositiveInteger.
	interpreterProxy success:
		(interpreterProxy fetchClassOf: f1) = interpreterProxy classLargePositiveInteger.
	interpreterProxy failed ifTrue:[^ nil].

	prodLen := interpreterProxy stSizeOf: prod.
	f1Len := interpreterProxy stSizeOf: f1.
	f2Len := interpreterProxy stSizeOf: f2.
	interpreterProxy success: (prodLen = (f1Len + f2Len)).
	interpreterProxy failed ifTrue:[^ nil].

	prodPtr := interpreterProxy firstIndexableField: prod.
	f2Ptr := interpreterProxy firstIndexableField: f2.
	f1Ptr := interpreterProxy firstIndexableField: f1.

	0 to: f1Len-1 do: [:i | 
		(digit := f1Ptr at: i) ~= 0 ifTrue: [
			carry := 0.
			k := i.
			"Loop invariants: 0 <= carry <= 16rFF, k = i + j - 1"
			0 to: f2Len-1 do: [:j | 
				sum := ((f2Ptr at: j) * digit) + (prodPtr at: k) + carry.
				carry := sum bitShift: -8.
				prodPtr at: k put: (sum bitAnd: 255).
				k := k + 1].
			prodPtr at: k put: carry]].

	interpreterProxy pop: 3.
