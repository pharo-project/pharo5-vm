testing
isAFixup: fixupOrAddress
	<var: #fixupOrAddress type: #'void *'>
	^cogit addressIsInFixups: fixupOrAddress