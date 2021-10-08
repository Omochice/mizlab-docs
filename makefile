.PHORY: lint
lint:
	@$(shell npm bin)/textlint docs/**/*.md

.PHONY: fix
fix:
	@$(shell npm bin)/textlint docs/**/*.md --fix


