transforming
extractSuppressFailureGuardDirective
	"Scan the top-level statements for a pragma directive of the form:

		self suppressFailureGuards: <boolean>

	 and remove the directive from the method body. Answer the argument
	 of the directive or false if there is no #supressFailureGuards: directive."

	^self
		extractDirective: #suppressFailureGuards:
		valueBlock: [:sendNode| sendNode args first name = 'true']
		default: false