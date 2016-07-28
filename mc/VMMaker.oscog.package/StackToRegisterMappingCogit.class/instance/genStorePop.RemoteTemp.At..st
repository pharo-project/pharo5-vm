bytecode generator stores
genStorePop: popBoolean RemoteTemp: slotIndex At: remoteTempIndex
	<inline: true>
	^ self genStorePop: popBoolean RemoteTemp: slotIndex At: remoteTempIndex needsStoreCheck: self ssTopNeedsStoreCheck