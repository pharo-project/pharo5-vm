private-support
testInterpreterProxyInterfaceIsConsistentFor: aClass
	| ccg |
	ccg := VMPluginCodeGenerator new.
	InterpreterProxy selectors asArray sort do:
		[:sel| | pm |
		((#(initialize #'initialize-release' private) includes: (InterpreterProxy whichCategoryIncludesSelector: sel))
		  or: [ccg noteUsedPluginFunction: sel]) ifFalse:
			[pm := ccg compileToTMethodSelector: sel in: InterpreterProxy.
			(aClass whichClassIncludesSelector: sel) ifNotNil:
				[:impClass| | im pt it |
				im := ccg compileToTMethodSelector: sel in: impClass.
				"A number of functions are actually void in the interpreter but declared as sqInt in sqVirtualMachine.c, e.g. push"
				self assert: ((pt := pm returnType) = (it := im returnType)
							 or: [pt = #sqInt and: [it = #void]])
					description: 'inconsistent returnType for ', sel, ' in InterpreterProxy vs ', impClass, ' ', pt, ' vs ', it.
				pm args doWithIndex:
					[:pma :i| | ima |
					ima := im args at: i.
					self assert: (pt := pm typeFor: pma in: ccg) = (it := im typeFor: ima in: ccg)
						description: 'inconsistent ', i printString, (#('st' 'nd') at: i ifAbsent: 'th'), ' arg type for ', sel, ' in InterpreterProxy vs ', impClass, ' ', pt, ' vs ', it]]]]