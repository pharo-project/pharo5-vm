transformations
extractExportDirective
	"Scan the top-level statements for an inlining directive of the form:

		self export: <boolean>

	 and remove the directive from the method body. Answer the
	 argument of the directive or false if there is no export directive."

	^self
		extractDirective: #export:
		valueBlock: [:sendNode| sendNode args first value ~= false]
		default: false