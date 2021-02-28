const disqusShortname = document.getElementById('comments').getAttribute('data-name')
const button = document.getElementById('show-comments-button')

button.onclick = function loadComments () {
  let disqusLoaded = false

  if (!disqusLoaded) {
    disqusLoaded = true;

    (function () {
      const doc = document
      const scripts = doc.createElement('script')
      scripts.src = 'https://' + disqusShortname + '.disqus.com/embed.js'
      scripts.setAttribute('data-timestamp', +new Date());
      (doc.head || doc.body).appendChild(scripts)
    })()

    document.getElementById('show-comments-button').remove()
  };
}
