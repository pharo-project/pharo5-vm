combination rules
partitionedAdd: word1 to: word2 nBits: nBits componentMask: componentMask carryOverflowMask: carryOverflowMask
	"Add word1 to word2 as nParts partitions of nBits each.
	This is useful for packed pixels, or packed colors"
	| carryOverflow sum w1 w2 |
	"Use unsigned int everywhere because it has a well known arithmetic model without undefined behavior w.r.t. overflow and shifts"
	<returnTypeC: 'unsigned int'>
	 <var: #word1 type: 'unsigned int'>
	<var: #word2 type: 'unsigned int'>
	 <var: #w1 type: 'unsigned int'>
	<var: #w2 type: 'unsigned int'>
	<var: #componentMask type: 'unsigned int'>
	<var: #carryOverflowMask type: 'unsigned int'>
	<var: #carryOverflow type: 'unsigned int'>
	<var: #sum type: 'unsigned int'>
	w1 := word1 bitAnd: carryOverflowMask. "mask to remove high bit of each component"
	w2 := word2 bitAnd: carryOverflowMask.
	sum := (word1 bitXor: w1)+(word2 bitXor: w2). "sum without high bit to avoid overflowing over next component"
	carryOverflow := (w1 bitAnd: w2) bitOr: ((w1 bitOr: w2) bitAnd: sum). "detect overflow condition for saturating"
	^((sum bitXor: w1)bitXor:w2) "sum high bit without overflow"
		bitOr: carryOverflow>>(nBits-1) * componentMask "saturate in case of overflow"