primitives
primSetCompositionWindowPositionX: x y: y

	| ret |

	<export: true>
	self primitive: 'primSetCompositionWindowPosition'
		parameters: #(SmallInteger SmallInteger).
	

	ret := self cCode: 'setCompositionWindowPosition(x, y)'.

	ret = false ifTrue: [
		interpreterProxy primitiveFail.
		^ nil
	].

	^ ret asOop: Boolean

