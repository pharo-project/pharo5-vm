private
pairs: aRange do: aBinaryBlock
	aRange do: [:a| aRange do: [:b| aBinaryBlock value: a value: b]]