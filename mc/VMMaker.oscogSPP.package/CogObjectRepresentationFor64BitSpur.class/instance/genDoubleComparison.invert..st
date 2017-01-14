primitive generators
genDoubleComparison: jumpOpcodeGenerator invert: invertComparison
	<inline: true>
	^self genFloatComparison: jumpOpcodeGenerator invert: invertComparison boxed: true