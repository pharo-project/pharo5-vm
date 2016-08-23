testing
testFindSubstringInWideString
	"The primitive will fail if invoked on a non-byte receiver. WideString does
	not call the primitive, so this is an expected failure."

	| position |
	position := MiscPrimitivePluginTest new
				findSubstring: 'bc'
				in: 'abcdef' asWideString
				startingAt: 1
				matchTable: ((0 to: 255)
						as: ByteArray).
	self assert: position = 0.
	position := MiscPrimitivePluginTest new
				findSubstring: 'bc' asWideString
				in: 'abcdef' asWideString
				startingAt: 1
				matchTable: ((0 to: 255)
						as: ByteArray).
	self assert: position = 2
