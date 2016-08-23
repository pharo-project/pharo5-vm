initialization
initializeMethodIndices
	| tagBits |
	"Class CompiledMethod"
	HeaderIndex := 0.
	LiteralStart := 1.

	tagBits := self objectMemoryClass numSmallIntegerTagBits.
	LargeContextBit := 16r20000 << tagBits.  "This bit set in method headers if large context is needed."
	MethodHeaderTempCountShift := 18 + tagBits.
	MethodHeaderArgCountShift := 24 + tagBits.
	V3PrimitiveBitsMask := 16r100001FF << tagBits.
	AlternateHeaderHasPrimFlag := 16r10000 << tagBits.
	AlternateHeaderIsOptimizedFlag := 16r8000 << tagBits.
	AlternateHeaderNumLiteralsMask := 16r7FFF. "N.B.  *not* shifted"
	"The position of the unused flag bit in the method header, not including tag bit(s).
	 Bits 28 & 29 are either used as an accessModifer code in Newspeak (public, private, protected)
	 or are free for use as flag bits."
	MethodHeaderFlagBitPosition := 28 + tagBits.
	AccessModifierPublic := 2r00.
	AccessModifierPrivate := 2r01.
	AccessModifierProtected := 2r10.