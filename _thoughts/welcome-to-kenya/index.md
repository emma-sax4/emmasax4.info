---
layout: thoughts
title: Thoughts
order: 4
permalink: /thought/welcome-to-kenya
---

<h1>Welcome to Kenya</h1>

A complilation thoughts all revolving around my trip to Kenya in the summer of 2019.

{% assign all_thoughts = site.thoughts | sort:"date" | reverse %}
{% assign thoughts_to_show =  all_thoughts | where: "title", "Welcome to Kenya" %}
