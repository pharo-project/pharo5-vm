private
check: obj
	<inline: true>
	self cCode: '' inSmalltalk: [obj = interestingObj ifTrue: [self halt]]