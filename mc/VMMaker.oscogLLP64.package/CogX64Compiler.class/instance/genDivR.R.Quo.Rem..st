abstract instructions
genDivR: abstractRegDivisor R: abstractRegDividend Quo: abstractRegQuotient Rem: abstractRegRemainder
	| rDividend rDivisor rQuotient rRemainder saveRestoreEAX saveRestoreEDX saveRestoreExchanged |
	self assert: abstractRegDividend ~= abstractRegDivisor.
	self assert: abstractRegQuotient ~= abstractRegRemainder.
	rDividend := abstractRegDividend.
	rDivisor := abstractRegDivisor.
	rQuotient := abstractRegQuotient.
	rRemainder := abstractRegRemainder.
	"IDIV r does a signed divide of RDX:RAX by r, RAX := Quotient, RDX := Remainder.
	 Since we must sign extend the dividend into RDX we must substitute another register if RDX is an input."
	(rDividend = RDX or: [rDivisor = RDX]) ifTrue:
		[| rUnused |
		"Slang, sigh..."
		rUnused := RAX.
		[rUnused <= RDI] whileTrue:
			[(rUnused ~= RSP and: [rUnused ~= RBP and: [rUnused ~= RDX
			  and: [rUnused ~= rDividend and: [rUnused ~= rDivisor
			  and: [rUnused ~= rQuotient and: [rUnused ~= rRemainder]]]]]]) ifTrue:
				[cogit PushR: rUnused.
				cogit MoveR: RDX R: rUnused.
				rDividend = RDX
					ifTrue: [self genDivR: rDivisor R: rUnused Quo: rQuotient Rem: rRemainder]
					ifFalse: [self genDivR: rUnused R: rDividend Quo: rQuotient Rem: rRemainder].
				cogit PopR: rUnused.
				^self].
			  rUnused := rUnused + 1].
		self error: 'couldn''t find unused register in genDivR:R:Quo:Rem:'].
	"If either output does not include RAX or RDX we must save and restore RAX and/or RDX."
	(saveRestoreEAX := rQuotient ~= RAX and: [rRemainder ~= RAX]) ifTrue:
		[cogit PushR: RAX].
	(saveRestoreEDX := rQuotient ~= RDX and: [rRemainder ~= RDX]) ifTrue:
		[cogit PushR: RDX].
	saveRestoreExchanged := -1.
	rDividend ~= RAX ifTrue:
		[rDivisor = RAX
			ifTrue: [((rDividend ~= rQuotient and: [rDividend ~= rRemainder])
					and: [rDividend ~= RDX or: [saveRestoreEDX not]]) ifTrue:
						[cogit PushR: (saveRestoreExchanged := rDividend)].
					cogit gen: XCHGRR operand: rDivisor operand: rDividend]
			ifFalse: [cogit MoveR: rDividend R: RAX]].
	"CDQ sign-extends RAX into RDX as required for IDIV"
	cogit gen: CDQ.
	cogit gen: IDIVR operand: (rDivisor = RAX ifTrue: [rDividend] ifFalse: [rDivisor]).
	"Must not overwrite result while juggling"
	(rQuotient = RDX and: [rRemainder = RAX])
		ifTrue: [cogit gen: XCHGRR operand: rQuotient operand: rRemainder]
		ifFalse:
			[rQuotient = RDX
				ifTrue:
					[rRemainder ~= RDX ifTrue:
						[cogit MoveR: RDX R: rRemainder].
					rQuotient ~= RAX ifTrue:
						[cogit MoveR: RAX R: rQuotient]]
				ifFalse:
					[rQuotient ~= RAX ifTrue:
						[cogit MoveR: RAX R: rQuotient].
					rRemainder ~= RDX ifTrue:
						[cogit MoveR: RDX R: rRemainder]]].
	saveRestoreExchanged >= 0 ifTrue:
		[cogit PopR: saveRestoreExchanged].
	saveRestoreEDX ifTrue:
		[cogit PopR: RDX].
	saveRestoreEAX ifTrue:
		[cogit PopR: RAX]