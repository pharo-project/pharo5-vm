interpreting
doIt
	"Answer a string corresponding to the result of executing my script in the default context. mode 0.  As a side-effect, update my script information as necessary."

	^self doAsOSAID: [:scptOSAID |
		ApplescriptGeneric executeAndDisplayOSAID: scptOSAID in: (OSAID new) mode: 0]