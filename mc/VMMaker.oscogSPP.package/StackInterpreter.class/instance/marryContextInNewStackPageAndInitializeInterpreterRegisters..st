frame access
marryContextInNewStackPageAndInitializeInterpreterRegisters: aContext
	"Establish aContext at the base of a new stackPage, make the stackPage the
	 active one and set-up the interreter registers.  This is used to boot the system
	 and bring it back after a snapshot."
	<inline: false>
	| newPage |
	<var: #newPage type: #'StackPage *'>
	self assert: stackPage = 0.
	newPage := self makeBaseFrameFor: aContext.
	self setStackPageAndLimit: newPage.
	framePointer := stackPage headFP.
	stackPointer := stackPage headSP.
	self setMethod: (self iframeMethod: stackPage headFP).
	instructionPointer := self popStack