primitive generators
maybeCompileRetryOnPrimitiveFail: primIndex
	"Object representations with lazy forwarding will want to check for
	 forwarding pointers on primitive failure and retry the primitive if found.
	 By default do nothing."
	<inline: true>