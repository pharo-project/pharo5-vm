exported functions
secCan: socket ListenOnPort: port
	<export: true>
	^self cCode: 'ioCanListenOnPort(socket, port)'