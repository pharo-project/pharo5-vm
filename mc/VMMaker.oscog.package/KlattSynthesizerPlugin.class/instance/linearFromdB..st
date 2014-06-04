processing
linearFromdB: aNumber
	<inline: true>
	<returnTypeC: 'float'>
	<var: 'aNumber' type: 'double '>
	^ (2.0 raisedTo: (aNumber-87.0/6.0)) * 32.767