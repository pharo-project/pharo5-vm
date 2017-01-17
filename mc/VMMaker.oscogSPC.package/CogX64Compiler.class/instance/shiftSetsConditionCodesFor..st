testing
shiftSetsConditionCodesFor: aConditionalJumpOpcode
	"OF flag only guaranteed to be set for 1-bit shifts.  See [1] p 490.
	 Only SF, ZF & PF set according to result.  Since the question is currently
	 asked only for Zero and Negative use the following simplification."
	<inline: true>
	^(aConditionalJumpOpcode between: JumpZero and: JumpNonNegative)