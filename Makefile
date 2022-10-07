.PHONY: presentation pdf
presentation:
	mdslides --include medias presentation.md

pdf:
	mdslides --include medias --pdf presentation.md
