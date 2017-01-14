exported functions
secCanCreate: netType SocketOfType: socketType
	<export: true>
	^self cCode: 'ioCanCreateSocketOfType(netType, socketType)'