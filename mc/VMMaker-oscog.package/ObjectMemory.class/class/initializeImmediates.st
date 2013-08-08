initialization
initializeImmediates
	"The Squeak VM supports 31-bit immediate 2's compliment SmallInteger objects as the only immediate type."
	ImmediateTagMask := SmallIntegerShift := 1