---
citekey: {{citekey}}
title: {{title}}
tags:
  - literature/unfiled
---

# {{title}}

> [!cite]
> {{bibliography}}

{% if relations.length > 0 -%}
> [!note] Related
> {% for relation in relations | selectattr("citekey") %}
> - [[@{{relation.citekey}}]]{% endfor %}
{%- endif %}

{% set filelinks = attachments | filterby("path", "endswith", ".pdf") %}
{% if filelinks.length > 0 -%}
> [!info] Links
> {%- for filelink in filelinks %}
> - [{{filelink.title}}](file://{{filelink.path | replace(" ", "%20")}}){%- endfor -%}
{%- endif %}

{% if abstractNote -%}
> [!Abstract]-
>
> {{abstractNote}}
{%- endif %}

## Annotations

{%- macro calloutHeader(type) -%}
	{%- switch type -%}
		{%- case "highlight" -%}
			Highlight
		{%- case "strike" -%}
			Strikethrough
		{%- case "underline" -%}
			Underline
		{%- case "image" -%}
			Image
		{%- default -%}
			Note
	{%- endswitch -%}
{%- endmacro %}

{% persist "annotations" %}
{% set annots = annotations | filterby("date", "dateafter", lastImportDate) -%}
{% if annots.length > 0 %}

{% for annot in annots -%}
> [!quote] {{calloutHeader(annot.type)}}
{%- if calloutHeader(annot.type) == "Note" %}
{% for line in annot.comment.split('\n') -%}
> {{line}}
{% endfor %}
{%- else %}
{%- if annot.annotatedText %}
> <mark{% if annot.color %} style="background-color: {{annot.color}}"{% endif %}>{{annot.annotatedText | nl2br}}</mark>
{%- endif -%}
{%- if annot.imageRelativePath %}
> ![[{{annot.imageRelativePath}}]]
{%- endif %}
{%- if annot.ocrText %}
> {{annot.ocrText}}
{%- endif %}
{%- if annot.comment %}
>
{% for line in annot.comment.split('\n') -%}
>> {{line}}
{%- endfor -%}
{%- endif %}
>
> [Page {{annot.page}}](zotero://open-pdf/library/items/{{annot.attachment.itemKey}}?page={{annot.page}}) [{{annot.date | format("YYYY-MM-DD#h:mm a")}}]
{%- endif %}

{% endfor -%}
{% endif %}
{% endpersist %}

> [!metadata]-
{% for type, creators in creators | groupby("creatorType") -%}
{%- for creator in creators -%}
> **{{"First" if loop.first}}{{type | capitalize}}**::
{%- if creator.name %} {{creator.name}}
{%- else %} {{creator.lastName}}, {{creator.firstName}}
{%- endif %}
{% endfor %}~
{%- endfor %}
> **Title**:: {{title}}
> **Year**:: {{date | format("YYYY")}}
> **Citekey**:: {{citekey}} {%- if itemType %}
> **itemType**:: {{itemType}}{%- endif %}{%- if itemType == "journalArticle" %}
> **Journal**:: *{{publicationTitle}}* {%- endif %}{%- if volume %}
> **Volume**:: {{volume}} {%- endif %}{%- if issue %}
> **Issue**:: {{issue}} {%- endif %}{%- if itemType == "bookSection" %}
> **Book**:: {{publicationTitle}} {%- endif %}{%- if publisher %}
> **Publisher**:: {{publisher}} {%- endif %}{%- if place %}
> **Location**:: {{place}} {%- endif %}{%- if pages %}
> **Pages**:: {{pages}} {%- endif %}{%- if DOI %}
> **DOI**:: {{DOI}} {%- endif %}{%- if ISBN %}
> **ISBN**:: {{ISBN}} {%- endif %}
