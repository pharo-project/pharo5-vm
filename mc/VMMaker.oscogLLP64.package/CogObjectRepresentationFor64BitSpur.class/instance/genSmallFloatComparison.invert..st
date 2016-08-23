primitive generators
genSmallFloatComparison: jumpOpcodeGenerator invert: invertComparison
	<inline: true>
	^self genFloatComparison: jumpOpcodeGenerator invert: invertComparison boxed: false