function loadComments(disqus_shortname) {
  var disqus_loaded = false;

  if (!disqus_loaded) {
    disqus_loaded = true;

    (function() {
      var doc = document;
      var scripts = doc.createElement('script');
      scripts.src = 'https://' + disqus_shortname + '.disqus.com/embed.js';
      scripts.setAttribute('data-timestamp', +new Date());
      (doc.head || doc.body).appendChild(scripts);
    })();

    document.getElementById('show-comments-button').remove();
  };
};
