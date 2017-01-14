abstract instructions
genDivR: abstractRegDivisor R: abstractRegDividend Quo: abstractRegQuotient Rem: abstractRegRemainder
	cogit gen: DivRR operand: abstractRegDividend operand: abstractRegDivisor.
	cogit gen: MoveLowR operand: abstractRegQuotient.
	cogit gen: MoveHighR operand: abstractRegRemainder.
	^0