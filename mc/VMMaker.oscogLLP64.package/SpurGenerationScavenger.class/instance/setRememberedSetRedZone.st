remembered set
setRememberedSetRedZone
	| fudge |
	<inline: true>
	"fudge is a minimum below which we don't care about growing the RT.
	 It is chosen so that with a default 4Mb new space, the RT is not considered
	 full until it has from 512 to 1024 entries."
	fudge := eden limit - eden start / manager wordSize // 1024.
	rememberedSetRedZone := rememberedSetLimit * 3 // 4 max: fudge