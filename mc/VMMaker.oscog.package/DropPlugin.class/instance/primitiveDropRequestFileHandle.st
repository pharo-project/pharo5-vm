primitives
primitiveDropRequestFileHandle
	"Note: File handle creation needs to be handled by specific support code explicitly bypassing the plugin file sand box."
	| dropIndex handleOop |
	<export: true>
	<inline: false>
	interpreterProxy methodArgumentCount = 1 
		ifFalse:[^interpreterProxy primitiveFail].
	dropIndex := interpreterProxy stackIntegerValue: 0.
	handleOop := self dropRequestFileHandle: dropIndex.
	"dropRequestFileHandle needs to return the actual oop returned"
	interpreterProxy failed ifFalse:[
		interpreterProxy pop: 2.
		interpreterProxy push: handleOop.
	].