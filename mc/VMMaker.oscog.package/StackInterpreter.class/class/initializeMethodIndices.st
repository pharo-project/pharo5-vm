initialization
initializeMethodIndices
	| tagBits |
	"Class CompiledMethod"
	HeaderIndex := 0.
	LiteralStart := 1.

	tagBits := self objectMemoryClass numSmallIntegerTagBits.
	LargeContextBit := 16r20000 << tagBits.  "This bit set in method headers if large context is needed."
	MethodHeaderOptimizedBitShift := 28 + tagBits.
	MethodHeaderTempCountShift := 18 + tagBits.
	MethodHeaderArgCountShift := 24 + tagBits.
	V3PrimitiveBitsMask := 16r100001FF << tagBits.
	AlternateHeaderHasPrimFlag := 16r10000 << tagBits.
	"The position of the unused flag bit in the method header, not including tag bit(s)"
	HeaderFlagBitPosition := 29