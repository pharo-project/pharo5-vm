private
shortRunValueAt: i from: runArray
	"Return the run-length value from the given ShortRunArray.
	Note: We don't need any coercion to short/int here, since
	we deal basically only with unsigned values."
	^(((self cCoerce: runArray to:'int *') at: i) bitAnd: 16rFFFF)