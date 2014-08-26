spur compilation support
isStackAccessor: selector
	^(StackInterpreter whichCategoryIncludesSelector: selector) = #'stack access'