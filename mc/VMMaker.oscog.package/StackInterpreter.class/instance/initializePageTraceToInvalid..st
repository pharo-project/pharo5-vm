stack pages
initializePageTraceToInvalid: aPage
	<var: #aPage type: #'StackPage *'>
	aPage trace: StackPageTraceInvalid "for assert checking of the page tracing flags"