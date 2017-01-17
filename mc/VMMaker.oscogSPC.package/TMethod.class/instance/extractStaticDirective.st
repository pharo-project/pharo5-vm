transformations
extractStaticDirective
	"Scan the top-level statements for an inlining directive of the form:

		self static: <boolean>

	 and remove the directive from the method body. Answer the
	 argument of the directive or true if there is no static directive."

	^self
		extractDirective: #static:
		valueBlock: [:sendNode| sendNode args first value ~= false]
		default: (export or: [(properties includesKey: #api) or: [properties includesKey: #api:]]) not