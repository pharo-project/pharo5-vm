lines-simple
stepToFirstLine
	"Initialize the current entry in the GET by stepping to the current scan line"
	<inline: true>
	^self stepToFirstLineIn: (getBuffer at: self getStartGet) at: self currentYGet