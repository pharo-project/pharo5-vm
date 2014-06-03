testing
testFindSubstringOldVersionWithMissingTypeChecks
	"Verify that primitive exists in the VM. This test documents the behavior of older versions
	of the primitive that did not perform type checking on to fail on WideString parameters.
	Newer versions of the primitive handle this properly, hence this test is an expectedFailure.
	The fix for this issue (by Andreas Raab) is in TMethod>>argConversionExprFor:stackIndex:
	which was added to VMMaker in VMMaker-dtl.202.
	
	If this test passes, it is an indication that the TMethod>>argConversionExprFor:stackIndex:
	update is missing from the VMMaker code generator that produced the VM."
	
	"(MiscPrimitivePluginTest selector: #testArgsAsFlatArrayAndOffsets) run"

	| position |
	"If both receiver and argument are byte size, the primitive performs correctly"
	position := MiscPrimitivePluginTest new
				findSubstring: 'bc'
				in: 'abcdef'
				startingAt: 1
				matchTable: ((0 to: 255)
						as: ByteArray).
	self assert: position = 2.

	"Plugin accepts wide string argument, but should not do so."
	position := MiscPrimitivePluginTest new
				findSubstring: 'bc' asWideString
				in: 'abcdef'
				startingAt: 1
				matchTable: ((0 to: 255)
						as: ByteArray).
	self assert: position = 0.

	position := MiscPrimitivePluginTest new
				findSubstring: 'bc'
				in: 'abcdef' asWideString
				startingAt: 1
				matchTable: ((0 to: 255)
						as: ByteArray).
	self assert: position = 0.

	"Older versions of the plugin produce incorrect results here"
	position := MiscPrimitivePluginTest new
				findSubstring: 'bc' asWideString
				in: 'abcdef' asWideString
				startingAt: 1
				matchTable: ((0 to: 255)
						as: ByteArray).
	self assert: position = 5 "Incorrect!"
