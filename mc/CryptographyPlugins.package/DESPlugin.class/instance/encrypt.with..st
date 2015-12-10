support
encrypt: dataPtr with: key
	| fVal work right left |
	<var: 'dataPtr' declareC: 'unsigned long *dataPtr'>
	<var: 'key' declareC: 'unsigned long *key'>
	<var: 'fVal' declareC: 'unsigned long fVal'>
	<var: 'work' declareC: 'unsigned long work'>
	<var: 'right' declareC: 'unsigned long right'>
	<var: 'left' declareC: 'unsigned long left'>

	left := dataPtr at: 0.
	right := dataPtr at: 1.

	"perform required but otherwise pointless bit twizzling"
	work := ((left >> 4) bitXor: right) bitAnd: 16r0F0F0F0F.
	right := right bitXor: work.
	left := left bitXor: (work << 4).
	work := ((left >> 16) bitXor: right) bitAnd: 16r0000FFFF.
	right := right bitXor: work.
	left := left bitXor: (work << 16).
	work := ((right >> 2) bitXor: left) bitAnd: 16r33333333.
	left := left bitXor: work.
	right := right bitXor: (work << 2).
	work := ((right >> 8) bitXor: left) bitAnd: 16r00FF00FF.
	left := left bitXor: work.
	right := right bitXor: (work << 8).
	right := ((right << 1) bitOr: ((right >> 31) bitAnd: 1)) bitAnd: 16rFFFFFFFF.
	work := (left bitXor: right) bitAnd: 16rAAAAAAAA.
	left := left bitXor: work.
	right := right bitXor: work.
	left := ((left << 1) bitOr: ((left >> 31) bitAnd: 1)) bitAnd:
16rFFFFFFFF.

	"perform the 8 rounds of real encryption"
	0 to: 28 by: 4 do: [ :round |
		work := right << 28 bitOr: right >> 4.
		work := work bitXor: (key at: round).
		fVal := sp7 at: (work bitAnd: 16r3F).
		fVal := fVal bitOr: (sp5 at: (work >> 8 bitAnd: 16r3F)).
		fVal := fVal bitOr: (sp3 at: (work >> 16 bitAnd: 16r3F)).
		fVal := fVal bitOr: (sp1 at: (work >> 24 bitAnd: 16r3F)).

		work := right bitXor: (key at: round+1).
		fVal := fVal bitOr: (sp8 at: (work bitAnd: 16r3F)).
		fVal := fVal bitOr: (sp6 at: (work >> 8 bitAnd: 16r3F)).
		fVal := fVal bitOr: (sp4 at: (work >> 16 bitAnd: 16r3F)).
		fVal := fVal bitOr: (sp2 at: (work >> 24 bitAnd: 16r3F)).
		left := left bitXor: fVal.

		work := left << 28 bitOr: left >> 4.
		work := work bitXor: (key at: round+2).
		fVal := sp7 at: (work bitAnd: 16r3F).
		fVal := fVal bitOr: (sp5 at: (work >> 8 bitAnd: 16r3F)).
		fVal := fVal bitOr: (sp3 at: (work >> 16 bitAnd: 16r3F)).
		fVal := fVal bitOr: (sp1 at: (work >> 24 bitAnd: 16r3F)).

		work := left bitXor: (key at: round+3).
		fVal := fVal bitOr: (sp8 at: (work bitAnd: 16r3F)).
		fVal := fVal bitOr: (sp6 at: (work >> 8 bitAnd: 16r3F)).
		fVal := fVal bitOr: (sp4 at: (work >> 16 bitAnd: 16r3F)).
		fVal := fVal bitOr: (sp2 at: (work >> 24 bitAnd: 16r3F)).
		right := right bitXor: fVal.
		].

	"undo the pointless twizzling"
	right := right<<31 bitOr: right>>1.
	work := (left bitXor: right) bitAnd: 16rAAAAAAAA.
	left := left bitXor: work.
	right := right bitXor: work.
	left := left<<31 bitOr: left>>1.
	work := (left>>8 bitXor: right) bitAnd: 16r00FF00FF.
	right := right bitXor: work.
	left := left bitXor: work<<8.
	work := (left >> 2 bitXor: right) bitAnd: 16r33333333.
	right := right bitXor: work.
	left := left bitXor: work<<2.
	work := (right>>16 bitXor: left) bitAnd: 16r0000FFFF.
	left := left bitXor: work.
	right := right bitXor: work<<16.
	work := (right>>4 bitXor: left) bitAnd: 16r0F0F0F0F.
	left := left bitXor: work.
	right := right bitXor: work<<4.

	dataPtr at: 0 put: right.
	dataPtr at: 1 put: left.

	