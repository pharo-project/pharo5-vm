public api
setVMOwner: index
	<inline: false>
	self flag: #revisit.
	vmOwner := index.
	self sqLowLevelMFence