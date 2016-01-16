primitive generators
genSmallFloatArithmetic: arithmeticOperator preOpCheck: preOpCheckOrNil
	<inline: true>
	^self genFloatArithmetic: arithmeticOperator preOpCheck: preOpCheckOrNil boxed: false