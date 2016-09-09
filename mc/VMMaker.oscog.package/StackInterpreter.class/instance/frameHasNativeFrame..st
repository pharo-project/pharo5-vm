frame access
frameHasNativeFrame: theFP
	"See encodeFrameFieldHasContext:numArgs:"
	<inline: true>
	<option: #LowcodeVM>
	<var: #theFP type: #'char *'>
	| markObject |
	markObject := self temporary: (self frameNumArgs: theFP) in: theFP.
	
	^ markObject ~= objectMemory nilObject and: [ markObject = (objectMemory splObj: LowcodeContextMark)]