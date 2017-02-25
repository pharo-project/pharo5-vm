testing - MiscPrimitivePlugin
testFindSubstring
	"Verify that primitive exists in the VM and that non byte array arguments cause primitive to fail"

	| position |
	position := IncludedMethodsTest new
				findSubstring: 'bc'
				in: 'abcdef'
				startingAt: 1
				matchTable: ((0 to: 255)
						as: ByteArray).
	self assert: position = 2.
	self should: [IncludedMethodsTest new
				findSubstring: 'bc' asWideString
				in: 'abcdef'
				startingAt: 1
				matchTable: ((0 to: 255)
						as: ByteArray)]
					raise: Error.
	self should: [IncludedMethodsTest new
				findSubstring: 'bc'
				in: 'abcdef' asWideString
				startingAt: 1
				matchTable: ((0 to: 255)
						as: ByteArray)]
					raise: Error.
	self should: [IncludedMethodsTest new
				findSubstring: 'bc' asWideString
				in: 'abcdef' asWideString
				startingAt: 1
				matchTable: ((0 to: 255)
						as: ByteArray)]
					raise: Error
