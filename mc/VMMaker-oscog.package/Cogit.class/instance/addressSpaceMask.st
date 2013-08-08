accessing
addressSpaceMask
	<doNotGenerate>
	"Quad-byte-align, because the ARM requires 4-byte aligned jump & call targets."
	^((1 << (8 * BytesPerWord)) - 1) bitAnd: -4