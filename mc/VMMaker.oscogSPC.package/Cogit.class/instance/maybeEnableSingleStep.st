simulation only
maybeEnableSingleStep
	<inline: true>
	self cCode: '' inSmalltalk:
		[singleStep ifFalse: [singleStep := breakPC singleStepRequiredToTriggerIn: self]]