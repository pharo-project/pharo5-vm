testing
shouldRunSelector: selector
	"Tells whether the given selector is in the form bench*, and thus is a benchmark that should be executed."
	
	(selector includes: $:) ifTrue: [ ^ false ].
	^ selector beginsWith: #bench