private
logPhase: phaseName
	<inline: true>
	self cCode: '' inSmalltalk: [coInterpreter transcript nextPutAll: phaseName; flush].