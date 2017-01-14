debug printing
shortPrintFramesInPage: thePage
	<export: true> "use export: not api, so it won't be written to cointerp.h. cogit.c is unaware of StackPage"
	<inline: false>
	<var: #thePage type: #'StackPage *'>
	self printFrameAndCallers: thePage headFP SP: thePage headSP short: true