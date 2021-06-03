import PhotoSwipeLightbox from './photoswipe-lightbox.esm.min.js'

const options = {
  gallerySelector: '.photoswipe-gallery',
  childSelector: '.photoswipe',
  pswpModule: '/assets/js/photoswipe.esm.min.js',
  pswpCSS: '/assets/css/photoswipe.min.css'
}

const lightbox = new PhotoSwipeLightbox(options)

lightbox.on('uiRegister', function() {
  lightbox.pswp.ui.registerElement({
    name: 'custom-caption',
    order: 9,
    isButton: false,
    appendTo: 'root',
    html: 'Caption Text',
    onInit: (el, pswp) => {
      lightbox.pswp.on('change', () => {
        const currentSlideElement = lightbox.pswp.currSlide.data.element
        const hiddenCaption = currentSlideElement.querySelector('.hidden-caption-content')

        if (hiddenCaption == "" || hiddenCaption == null) {
          const customCaptionElements = document.getElementsByClassName('pswp__custom-caption')
          for (var counter = 0; counter < customCaptionElements.length; counter++) {
            customCaptionElements[counter].remove()
          }
        } else {
          let captionHTML = '';
          if (currentSlideElement) {
            captionHTML = hiddenCaption.innerHTML;
          }
          el.innerHTML = captionHTML || '';
        }
      })
    }
  })
})

lightbox.init()
