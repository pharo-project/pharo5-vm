private
logPhase: phaseName
	<inline: true>
	self break.
	self cCode: '' inSmalltalk: [coInterpreter transcript nextPutAll: phaseName; flush]. 