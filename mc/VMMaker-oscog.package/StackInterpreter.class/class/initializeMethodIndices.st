initialization
initializeMethodIndices
	"Class CompiledMethod"
	HeaderIndex := 0.
	LiteralStart := 1.

	LargeContextBit := 16r40000.  "This bit set in method headers if large context is needed."
	"The position of the unused flag bit in the method header, not including tag bit(s)"
	HeaderFlagBitPosition := 29