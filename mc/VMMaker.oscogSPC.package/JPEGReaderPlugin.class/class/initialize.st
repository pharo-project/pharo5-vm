class initialization
initialize
	"JPEGReaderPlugin initialize"
	DCTSize := 8.
	MaxSample := (2 raisedToInteger: DCTSize) - 1.
	SampleOffset := MaxSample // 2.
	DCTSize2 := DCTSize squared.
	ConstBits := 13.
	Pass1Bits := 2.
	Pass1Div := 1 bitShift: ConstBits - Pass1Bits.
	Pass2Div := 1 bitShift: ConstBits + Pass1Bits + 3.

	"fixed-point Inverse Discrete Cosine Transform (IDCT) constants"
	FIXn0n298631336 := 2446.
	FIXn0n390180644 := 3196.
	FIXn0n541196100 := 4433.
	FIXn0n765366865 := 6270.
	FIXn0n899976223 := 7373.
	FIXn1n175875602 := 9633.
	FIXn1n501321110 := 12299.
	FIXn1n847759065 := 15137.
	FIXn1n961570560 := 16069.
	FIXn2n053119869 := 16819.
	FIXn2n562915447 := 20995.
	FIXn3n072711026 := 25172.

	"fixed-point color conversion constants"
	FIXn0n34414 := 22554.
	FIXn0n71414 := 46802.
	FIXn1n40200 := 91881.
	FIXn1n77200 :=  116130.

	CurrentXIndex := 0.
	CurrentYIndex := 1.
	HScaleIndex := 2.
	VScaleIndex := 3.
	MCUBlockIndex := 4.
	BlockWidthIndex := 5.
	MCUWidthIndex := 8.
	PriorDCValueIndex := 10.
	MinComponentSize := 11.

	RedIndex := 0.
	GreenIndex := 1.
	BlueIndex := 2.

	MaxMCUBlocks := 128.
	MaxBits := 16.