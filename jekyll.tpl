{# /Users/Choiwansik/anaconda3/lib/python3.8/site-packages/nbconvert/templates #}
{% extends 'markdown.tpl' %}

{%- block header -%}
---
layout: post
title: "{{resources['metadata']['name']}}"
category: "DS/DL"
comments: true
tags: ["jupeter notebook"]
feature-img: "assets/img/26.jpg"
feature-title: ""
use_math: true
series: ""
summary: "요약할 글을 입력하세요."
---
{%- endblock header -%}

{% block in_prompt %}
<div class="prompt input_prompt">
In&nbsp;[{{ cell.execution_count }}]:
</div>
{% endblock in_prompt %}

{% block input %}
<div class="input_area" markdown="1">
{{ super() }}
</div>
{% endblock input %}

{% block stream %}
{: .output_stream}

```
{{ output.text }}
```
{% endblock stream %}

{% block data_text %}
{: .output_data_text}

```
{{ output.data['text/plain'] }}
```
{% endblock data_text %}

{% block traceback_line  %}
{: .output_traceback_line}

`{{ line | strip_ansi }}`

{% endblock traceback_line  %}

{% block data_html %}
<div markdown="0">
{{ output.data['text/html'] }}
</div>
{% endblock data_html %}
