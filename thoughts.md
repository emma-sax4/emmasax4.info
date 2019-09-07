---
title: Thoughts
order: 4
permalink: /thoughts/
layout: info
match_collection: thoughts
---

# What do I think about?

<ul>
  {% assign all_thoughts = site.thoughts | sort:"date" | reverse %}
  {% for thought in all_thoughts %}
    {% assign thought_url = thought.url | replace: '.html', '' | relative_url %}
    <span class="post-meta">{{ thought.date | date: "%B %-d, %Y" }}</span>

    <br>

    {% if thought.subtitle %}
      <a href="{{ thought_url | prepend: site.baseurl }}">{{ thought.title }} ☞ {{ thought.subtitle }}</a>
    {% else %}
      <a href="{{ thought_url | prepend: site.baseurl }}">{{ thought.title }}</a>
    {% endif %}
    <br><br>
  {% endfor %}
</ul>
<!-- <nav class="paginate-container" aria-label="Pagination">
<ul class="pagination"></ul>
</nav>

<!-- <script type="text/javascript">
  document.getElementById("papers").style.display = "none";
  document.getElementById("search-box").style.display = "block";
  var options = {
    valueNames: [ 'seminar-title', 'author', 'paper-title', 'paper-tags' ],
      page: 10,
      pagination: {outerWindow: 1,
                   innerWindow: 1}
  };
</script> -->
