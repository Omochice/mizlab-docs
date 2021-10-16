.PHORY: lint
lint:
	@$(shell npm bin)/textlint docs/**/*.md

.PHONY: fix
fix:
	@$(shell npm bin)/textlint docs/**/*.md --fix

.PHONY: article
article:
	@cp -n templates/article_template.md docs/$(shell date '+%Y-%m-%d').md \
		&& sed -i "s/POSTED_AT/$(shell date '+%Y-%m-%d')/" docs/$(shell date '+%Y-%m-%d').md \
		&& echo "📝 create new article docs/$(shell date '+%Y-%m-%d').md !!"

