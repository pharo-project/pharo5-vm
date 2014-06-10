primitives
primJPEGErrorMgr2StructSize
	<export: true>
	self
		primitive: 'primJPEGErrorMgr2StructSize'
		parameters: #().

	^(self cCode: 'sizeof(struct error_mgr2)' inSmalltalk: [0])
		asOop: SmallInteger