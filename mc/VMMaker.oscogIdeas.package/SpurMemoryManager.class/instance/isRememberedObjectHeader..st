object enumeration
isRememberedObjectHeader: objHeader
	"Answer if an object with header objHeader is remembered."
	<inline: true>
	^(objHeader >> self rememberedBitShift bitAnd: 1) ~= 0