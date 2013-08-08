initialization
initializeThreadSupport
	"Do this post new if you want to simulate with thread support."
	cogThreadManager := CogThreadManager new setInterpreter: self cogit: cogit.
	cogit setThreadManager: cogThreadManager