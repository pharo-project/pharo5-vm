simulation stack
register: reg isInMask: mask
	<inline: true>
	^ mask anyMask: (self registerMaskFor: reg)