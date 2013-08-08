private
absoluteSquared8Dot24: value
	"Compute the squared value of a 8.24 number with 0.0 <= value < 1.0,
	e.g., compute (value * value) bitShift: -24"
	| word1 word2 |
	<inline: true>
	word1 := value bitAnd: 16rFFFF.
	word2 := (value bitShift: -16) bitAnd: 255.
	^(( (self cCoerce: (word1 * word1) to:'unsigned') bitShift: -16) +
		((word1 * word2) * 2) +
			((word2 * word2) bitShift: 16)) bitShift: -8