primitives
setFileAccessCallback: address
	<export: true>
	<var: #address type: 'int'>
	^self cCode: 'sqSecFileAccessCallback((void *) address)'.