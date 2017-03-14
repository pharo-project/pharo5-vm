stack pages
setStackPointersFromPage: thePage
	<var: #thePage type: #'StackPage *'>
	<inline: true>
	stackPointer := thePage headSP.
	framePointer := thePage headFP