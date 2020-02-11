function loadComments(disqus_shortname) {
  var disqus_loaded = false;

  if (!disqus_loaded) {
    disqus_loaded = true;
    (function() {
      var d = document,
        s = d.createElement('script');
      s.src = 'https://' + disqus_shortname + '.disqus.com/embed.js';
      s.setAttribute('data-timestamp', +new Date());
      (d.head || d.body).appendChild(s);
    })();
    document.getElementById('show-comments-button').remove();
  };
};
