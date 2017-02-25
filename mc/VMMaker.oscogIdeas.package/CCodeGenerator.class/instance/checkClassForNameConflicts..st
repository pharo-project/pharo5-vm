error notification
checkClassForNameConflicts: aClass
	"Verify that the given class does not have constant, variable, or method names that conflict with
	 those of previously added classes. Raise an error if a conflict is found, otherwise just return."

	"check for constant name collisions in class pools"
	aClass classPool associationsDo:
		[:assoc |
		(constants includesKey: assoc key) ifTrue:
			[self error: 'Constant ', assoc key, ' was defined in a previously added class']].

	"and in shared pools"
	(aClass sharedPools reject: [:pool| pools includes: pool]) do:
		[:pool |
		pool bindingsDo:
			[:assoc |
			(constants includesKey: assoc key) ifTrue:
				[self error: 'Constant ', assoc key, ' was defined in a previously added class']]].

	"check for instance variable name collisions"
	(aClass inheritsFrom: VMStructType) ifFalse:
		[(self instVarNamesForClass: aClass) do:
			[:varName |
			(variables includes: varName) ifTrue:
				[self error: 'Instance variable ', varName, ' was defined in a previously added class']]].

	"check for method name collisions"
	aClass selectors do:
		[:sel | | tmeth meth |
		((self shouldIncludeMethodFor: aClass selector: sel)
		and: [(tmeth := methods at: sel ifAbsent: nil) notNil
		and: [(aClass isStructClass and: [(aClass isAccessor: sel)
				and: [(methods at: sel) isStructAccessor]]) not
		and: [(meth := aClass >> sel) isSubclassResponsibility not
		and: [(aClass includesBehavior: tmeth definingClass) not]]]]) ifTrue:
			[((aClass >>sel) pragmaAt: #option:)
				ifNil: [self error: 'Method ', sel, ' was defined in a previously added class.']
				ifNotNil:
					[logger
						ensureCr;
						show: 'warning, method ', aClass name, '>>', sel storeString,
								' overrides ', tmeth definingClass, '>>', sel storeString;
						cr]]]