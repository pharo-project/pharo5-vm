interpreter interface
loadBitBltFrom: bbObj
	"Load BitBlt from the oop.
	This function is exported for the Balloon engine."
	<export: true>
	^self loadBitBltFrom: bbObj warping: false.