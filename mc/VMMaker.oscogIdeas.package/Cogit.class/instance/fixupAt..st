compile abstract instructions
fixupAt: fixupPC
	<inline: true>
	^self fixupAtIndex: fixupPC - initialPC