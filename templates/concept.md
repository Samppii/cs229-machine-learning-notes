---
title: {{value:Concept name}}
tags:
- atom
aliases:
- <% tp.file.title.toLowerCase() %>
- <%* const { Pluralize } = await cJS(); tR += Pluralize.pluralize(tp.file.title.toLowerCase()) %>
- <% tp.file.title[0] + tp.file.title.substring(1).toLowerCase() %>
- <%* tR += Pluralize.pluralize(tp.file.title[0] + tp.file.title.substring(1).toLowerCase()) %>
---

# {{value:Concept name}}

## Summary
<%*
const path = require("node:path");

const entries = {
	units: [],
	tags: [],
};

const unitPath = await tp.system.clipboard();
if (unitPath && unitPath.endsWith('.md')) {
	const unit = path.basename(unitPath, ".md");
	const unitFile = tp.file.find_tfile(unitPath);
	const unitFrontmatter = await getFrontmatter(unitFile);

	if (unitFrontmatter.tags?.includes('index')) {
		entries.units = [`[[${unit}]]`];

		const tags = (unitFrontmatter.conceptTags?.length && unitFrontmatter.conceptTags?.length > 0) ? unitFrontmatter.conceptTags : unitFrontmatter.tags;
		switch (typeof tags) {
			case "string":
				if (tags !== 'index') entries.tags = [tags];
				break;
			case "object":
				entries.tags = tags.filter(tag => tag !== 'index');
				break;
		}
	}
}

function getFrontmatter(file) {
	return new Promise((res) => {
		app.fileManager.processFrontMatter(file, res);
	});
}

tp.hooks.on_all_templates_executed(async () => {
	const file = tp.file.find_tfile(tp.file.path(true));
	await app.fileManager.processFrontMatter(file, (frontmatter) => {
		for (const [key, value] of Object.entries(entries)) {
			if (key === 'tags') {
				frontmatter[key] = [...frontmatter[key], ...value];
			} else {
				frontmatter[key] = value;
			}
		}
	});
});
%>