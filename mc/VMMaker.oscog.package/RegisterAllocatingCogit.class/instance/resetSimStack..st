bytecode generator support
resetSimStack: startPC
	<inline: true>
	simSpillBase := methodOrBlockNumTemps.
	simStackPtr := methodOrBlockNumTemps - 1.
	self voidReceiverResultRegContainsSelf.
	self flushLiveRegistersForSend.
	self cCode: '' inSmalltalk:
		[0 to: methodOrBlockNumTemps - 1 do:
			[:i|
			(self simStackAt: i) bcptr: startPC]]