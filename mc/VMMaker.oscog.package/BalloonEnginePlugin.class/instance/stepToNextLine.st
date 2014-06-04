lines-simple
stepToNextLine
	"Process the current entry in the AET by stepping to the next scan line"
	<inline: true>
	^self stepToNextLineIn: (aetBuffer at: self aetStartGet) at: self currentYGet