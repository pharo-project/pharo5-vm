initialization
generateSistaRuntime
	"Trap sends Sista trap message to context with top of stack, so we don't need any arguments..."
	ceTrapTrampoline := self genTrampolineFor: #ceSistaTrap called: 'ceSistaTrapTrampoline'