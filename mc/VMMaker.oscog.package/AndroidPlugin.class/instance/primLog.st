system primitives
primLog
	| msg |
	<var: 'msg' type: 'char *'>
	<export: true>
	msg :=  self stringArgumentAt: 0.
	self primNativeLog: msg.
	interpreterProxy pop: 1. "leave rcvr on stack"
