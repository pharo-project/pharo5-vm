private
roundAndStoreResultPoint: nItemsToPop
	"Store the result of a previous operation.
	Fail if we cannot represent the result as SmallInteger"
	m23ResultX := m23ResultX + 0.5.
	m23ResultY := m23ResultY + 0.5.
	(self okayIntValue: m23ResultX) ifFalse:[^interpreterProxy primitiveFail].
	(self okayIntValue: m23ResultY) ifFalse:[^interpreterProxy primitiveFail].
	interpreterProxy pop: nItemsToPop thenPush:
		(interpreterProxy makePointwithxValue: m23ResultX asInteger
							yValue: m23ResultY asInteger)