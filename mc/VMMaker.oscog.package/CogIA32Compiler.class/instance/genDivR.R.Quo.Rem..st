abstract instructions
genDivR: abstractRegDivisor R: abstractRegDividend Quo: abstractRegQuotient Rem: abstractRegRemainder
	| rDividend rDivisor rQuotient rRemainder saveRestoreEAX saveRestoreEDX saveRestoreExchanged |
	self assert: abstractRegDividend ~= abstractRegDivisor.
	self assert: abstractRegQuotient ~= abstractRegRemainder.
	rDividend := abstractRegDividend.
	rDivisor := abstractRegDivisor.
	rQuotient := abstractRegQuotient.
	rRemainder := abstractRegRemainder.
	"IDIV r does a signed divide of EDX:EAX by r, EAX := Quotient, EDX := Remainder.
	 Since we must sign extend the dividend into EDX we must substitute another register if EDX is an input"
	(rDividend = EDX or: [rDivisor = EDX]) ifTrue:
		[| rUnused |
		"Slang, sigh..."
		rUnused := EAX.
		[rUnused <= EDI] whileTrue:
			[(rUnused ~= ESP and: [rUnused ~= EBP and: [rUnused ~= EDX
			  and: [rUnused ~= rDividend and: [rUnused ~= rDivisor
			  and: [rUnused ~= rQuotient and: [rUnused ~= rRemainder]]]]]]) ifTrue:
				[cogit PushR: rUnused.
				cogit MoveR: EDX R: rUnused.
				rDividend = EDX
					ifTrue: [self genDivR: rDivisor R: rUnused Quo: rQuotient Rem: rRemainder]
					ifFalse: [self genDivR: rUnused R: rDividend Quo: rQuotient Rem: rRemainder].
				cogit PopR: rUnused.
				^self].
			  rUnused := rUnused + 1].
		self error: 'couldn''t find unused register in genDivR:R:Quo:Rem:'].
	"If either output does not include EAX or EDX we must save and restore EAX and/or EDX."
	(saveRestoreEAX := rQuotient ~= EAX and: [rRemainder ~= EAX]) ifTrue:
		[cogit PushR: EAX].
	(saveRestoreEDX := rQuotient ~= EDX and: [rRemainder ~= EDX]) ifTrue:
		[cogit PushR: EDX].
	saveRestoreExchanged := -1.
	rDividend ~= EAX ifTrue:
		[rDivisor = EAX
			ifTrue: [((rDividend ~= rQuotient and: [rDividend ~= rRemainder])
					and: [rDividend ~= EDX or: [saveRestoreEDX not]]) ifTrue:
						[cogit PushR: (saveRestoreExchanged := rDividend)].
					cogit gen: XCHGRR operand: rDivisor operand: rDividend]
			ifFalse: [cogit MoveR: rDividend R: EAX]].
	"CDQ sign-extends EAX into EDX as required for IDIV"
	cogit gen: CDQ.
	cogit gen: IDIVR operand: (rDivisor = EAX ifTrue: [rDividend] ifFalse: [rDivisor]).
	"Must not overwrite result while juggling"
	(rQuotient = EDX and: [rRemainder = EAX])
		ifTrue: [cogit gen: XCHGRR operand: rQuotient operand: rRemainder]
		ifFalse:
			[rQuotient = EDX
				ifTrue:
					[rRemainder ~= EDX ifTrue:
						[cogit MoveR: EDX R: rRemainder].
					rQuotient ~= EAX ifTrue:
						[cogit MoveR: EAX R: rQuotient]]
				ifFalse:
					[rQuotient ~= EAX ifTrue:
						[cogit MoveR: EAX R: rQuotient].
					rRemainder ~= EDX ifTrue:
						[cogit MoveR: EDX R: rRemainder]]].
	saveRestoreExchanged >= 0 ifTrue:
		[cogit PopR: saveRestoreExchanged].
	saveRestoreEDX ifTrue:
		[cogit PopR: EDX].
	saveRestoreEAX ifTrue:
		[cogit PopR: EAX]