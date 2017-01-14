abstract instructions
DivR: rDivisor R: rDividend Quo: rQuotient Rem: rRemainder
	"Division is a little weird on some processors.  Defer to the backEnd
	 to allow it to generate any special code it may need to."
	<returnTypeC: #'AbstractInstruction *'>
	<inline: false>
	backEnd genDivR: rDivisor R: rDividend Quo: rQuotient Rem: rRemainder.
	^self abstractInstructionAt: opcodeIndex - 1