interpreting
doItIn: aContext
	"Answer a string corresponding to the result of executing my script in aContext. mode 0.  As a side-effect, update my script and the aContext information as necessary."

	^self doAsOSAID: [:scptContext |
		aContext asContextDoOSAID: scptContext mode: 0]