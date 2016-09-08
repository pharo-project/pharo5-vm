pixel mapping
expensiveDither32To16: srcWord threshold: ditherValue
	"Dither the given 32bit word to 16 bit. Ignore alpha."
	| pv threshold value out |
	<inline: true> "You bet"
	<returnTypeC: 'unsigned int'>
	<var: #srcWord type: 'unsigned int'>
	pv := srcWord bitAnd: 255.
	threshold := ditherThresholds16 at: (pv bitAnd: 7).
	value := ditherValues16 at: (pv bitShift: -3).
	ditherValue < threshold
		ifTrue:[out := value + 1]
		ifFalse:[out := value].
	pv := (srcWord bitShift: -8) bitAnd: 255.
	threshold := ditherThresholds16 at: (pv bitAnd: 7).
	value := ditherValues16 at: (pv bitShift: -3).
	ditherValue < threshold
		ifTrue:[out := out bitOr: (value+1 bitShift:5)]
		ifFalse:[out := out bitOr: (value bitShift: 5)].
	pv := (srcWord bitShift: -16) bitAnd: 255.
	threshold := ditherThresholds16 at: (pv bitAnd: 7).
	value := ditherValues16 at: (pv bitShift: -3).
	ditherValue < threshold
		ifTrue:[out := out bitOr: (value+1 bitShift:10)]
		ifFalse:[out := out bitOr: (value bitShift: 10)].
	^out