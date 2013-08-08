utilities
asByteArray
	"Answer a ByteArray containing my sample data serialized in most-significant byte first order."

	| sampleCount bytes dst s |
	sampleCount := self monoSampleCount.
	bytes := ByteArray new: 2 * sampleCount.
	dst := 0.
	1 to: sampleCount do: [:src |
		s := self at: src.
		bytes at: (dst := dst + 1) put: ((s bitShift: -8) bitAnd: 255).
		bytes at: (dst := dst + 1) put: (s bitAnd: 255)].
	^ bytes

	