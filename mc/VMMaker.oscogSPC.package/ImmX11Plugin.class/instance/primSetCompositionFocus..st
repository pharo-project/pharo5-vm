primitives
primSetCompositionFocus: bool

	| ret |
	<export: true>
	self primitive: 'primSetCompositionFocus'
		parameters: #(Boolean).
	
	ret := self cCode: 'setCompositionFocus(bool)'.

	ret = false ifTrue: [
		interpreterProxy primitiveFail.
		^ nil
	].

	^ ret asOop: Boolean
