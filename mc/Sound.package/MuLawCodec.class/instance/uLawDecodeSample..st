external access
uLawDecodeSample: byte
	"Decode a 16-bit signed sample from 8 bits using uLaw decoding"

	^ DecodingTable at: byte + 1