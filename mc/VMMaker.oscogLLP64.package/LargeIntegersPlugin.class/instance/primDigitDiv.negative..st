Integer primitives
primDigitDiv: secondInteger negative: neg 
	"Answer the result of dividing firstInteger by secondInteger. 
	Fail if parameters are not integers, not normalized or secondInteger is 
	zero. "
	| firstAsLargeInteger secondAsLargeInteger firstInteger |
	self debugCode: [self msg: 'primDigitDiv: secondInteger negative: neg'].
	firstInteger := self
				primitive: 'primDigitDivNegative'
				parameters: #(#Integer #Boolean )
				receiver: #Integer.
	"Coerce SmallIntegers to corresponding (not normalized) large integers  
	and check for zerodivide."
	(interpreterProxy isIntegerObject: firstInteger)
		ifTrue: ["convert to LargeInteger"
			self
				remapOop: secondInteger
				in: [firstAsLargeInteger := self createLargeFromSmallInteger: firstInteger]]
		ifFalse:
			["Avoid crashes in case of getting unnormalized args."
			(self isNormalized: firstInteger)
				ifFalse:
					[self debugCode:
						[self msg: 'ERROR in primDigitDiv: secondInteger negative: neg'.
						self msg: '------> receiver *not* normalized!'].
					^ interpreterProxy primitiveFail].
			firstAsLargeInteger := firstInteger].
	(interpreterProxy isIntegerObject: secondInteger)
		ifTrue: ["check for zerodivide and convert to LargeInteger"
			(interpreterProxy integerValueOf: secondInteger)
					= 0
				ifTrue: [^ interpreterProxy primitiveFail].
			self
				remapOop: firstAsLargeInteger
				in: [secondAsLargeInteger := self createLargeFromSmallInteger: secondInteger]]
		ifFalse:
			["Avoid crashes in case of getting unnormalized args."
			(self isNormalized: secondInteger)
				ifFalse:
					[self debugCode:
						[self msg: 'ERROR in primDigitDiv: secondInteger negative: neg'.
						self msg: '------> argument *not* normalized!'].
					^ interpreterProxy primitiveFail].
			secondAsLargeInteger := secondInteger].
	^ self
		digitDivLarge: firstAsLargeInteger
		with: secondAsLargeInteger
		negative: neg