testing
testFindSubstringInByteString
	"Verify that primitive exists in the VM and works as expected for byte
	sized string and key. If key is a WideString, as may be the case if testing
	for a WideString as substring of a byte sized string, then the primitive
	should fail. Earlier version of the primitive would accept the non-bytes
	parameter, leading to incorrect results, as documented in
	testFindSubstringOldVersionWithMissingTypeChecks"

	| position |
	position := MiscPrimitivePluginTest new
				findSubstring: 'bc'
				in: 'abcdef'
				startingAt: 1
				matchTable: ((0 to: 255)
						as: ByteArray).
	self assert: position = 2.
	self should: [MiscPrimitivePluginTest new
				findSubstring: 'bc' asWideString
				in: 'abcdef'
				startingAt: 1
				matchTable: ((0 to: 255)
						as: ByteArray)]
		raise: Error
	
