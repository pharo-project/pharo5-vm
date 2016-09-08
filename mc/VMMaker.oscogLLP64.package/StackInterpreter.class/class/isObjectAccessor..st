spur compilation support
isObjectAccessor: selector
	"Answer if selector is one of fetchPointer:ofObject: storePointer:ofObject:withValue:
	 et al."
	^(InterpreterProxy whichCategoryIncludesSelector: selector) = #'object access'
	 or: [(SpurMemoryManager whichCategoryIncludesSelector: selector) = #'object access']

	"This for checking.  The above two protocols are somewhat disjoint."
	"(InterpreterProxy allMethodsInCategory: #'object access') copyWithoutAll: (SpurMemoryManager allMethodsInCategory: #'object access')"
	"(SpurMemoryManager allMethodsInCategory: #'object access') copyWithoutAll: (InterpreterProxy allMethodsInCategory: #'object access')"