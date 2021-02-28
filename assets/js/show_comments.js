var disqusShortname = document.getElementById('comments').getAttribute('data-name');
var button = document.getElementById('show-comments-button');

button.onclick = function loadComments() {
  var disqusLoaded = false;

  if (!disqusLoaded) {
    disqusLoaded = true;

    (function() {
      var doc = document;
      var scripts = doc.createElement('script');
      scripts.src = 'https://' + disqusShortname + '.disqus.com/embed.js';
      scripts.setAttribute('data-timestamp', +new Date());
      (doc.head || doc.body).appendChild(scripts);
    })();

    document.getElementById('show-comments-button').remove();
  };
};
