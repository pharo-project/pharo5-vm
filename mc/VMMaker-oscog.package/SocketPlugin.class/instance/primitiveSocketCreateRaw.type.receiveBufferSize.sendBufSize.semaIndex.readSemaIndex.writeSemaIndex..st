primitives
primitiveSocketCreateRaw: netType type: protoType receiveBufferSize: recvBufSize sendBufSize: sendBufSize semaIndex: semaIndex readSemaIndex: aReadSema writeSemaIndex: aWriteSema 
	"New IPV6 implementation removes this... and nobody is using (and it wont compile)"
	<doNotGenerate>
	| socketOop s okToCreate |
	<var: #s type: 'SocketPtr '>
	self primitive: 'primitiveSocketCreateRAW' parameters: #(#SmallInteger #SmallInteger #SmallInteger #SmallInteger #SmallInteger #SmallInteger #SmallInteger ).
	"If the security plugin can be loaded, use it to check for permission.
	If not, assume it's ok"
	sCCSOTfn ~= 0
		ifTrue: [okToCreate := self cCode: ' ((int (*) (int, int)) sCCSOTfn)(netType, protoType)'.
			okToCreate
				ifFalse: [^ interpreterProxy primitiveFail]].
	socketOop := interpreterProxy instantiateClass: interpreterProxy classByteArray indexableSize: self socketRecordSize.
	s := self socketValueOf: socketOop.
	self
		sqSocket: s
		CreateRaw: netType
		ProtoType: protoType
		RecvBytes: recvBufSize
		SendBytes: sendBufSize
		SemaID: semaIndex
		ReadSemaID: aReadSema
		WriteSemaID: aWriteSema.
	^ socketOop