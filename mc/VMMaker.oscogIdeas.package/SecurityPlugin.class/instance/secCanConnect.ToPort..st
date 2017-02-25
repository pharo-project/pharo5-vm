exported functions
secCanConnect: addr ToPort: port
	<export: true>
	^self cCode: 'ioCanConnectToPort(addr, port)'