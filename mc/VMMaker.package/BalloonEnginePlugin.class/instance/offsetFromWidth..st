private
offsetFromWidth: lineWidth
	"Common function so that we don't compute that wrong in any place
	and can easily find all the places where we deal with one-pixel offsets."
	<inline: true>
	^lineWidth // 2