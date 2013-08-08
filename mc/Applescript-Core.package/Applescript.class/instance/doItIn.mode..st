interpreting
doItIn: aContext mode: anInteger
	"Answer a string corresponding to the result of executing my script in aContext. mode anInteger.  As a side-effect, update my script and the aContext information as necessary."

	^self doAsOSAID: [:scptContext |
		aContext asContextDoOSAID: scptContext mode: anInteger]