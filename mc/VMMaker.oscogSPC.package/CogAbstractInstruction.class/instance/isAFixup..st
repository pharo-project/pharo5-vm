testing
isAFixup: fixupOrAddress
	<var: #fixupOrAddress type: #'void *'>
	<inline: true>
	^cogit addressIsInFixups: fixupOrAddress