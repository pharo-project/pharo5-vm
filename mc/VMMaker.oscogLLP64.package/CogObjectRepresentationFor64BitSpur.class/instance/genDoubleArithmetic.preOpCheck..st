primitive generators
genDoubleArithmetic: arithmeticOperator preOpCheck: preOpCheckOrNil
	<inline: true>
	^self genFloatArithmetic: arithmeticOperator preOpCheck: preOpCheckOrNil boxed: true