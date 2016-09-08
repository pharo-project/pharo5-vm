simulation only
copySimStack
	<doNotGenerate>
	^CArrayAccessor on: (simStack object collect: [:stackEntry| stackEntry copy])