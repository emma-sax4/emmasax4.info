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
        const currentSlideElement = lightbox.pswp.currSlide.data.element;
        let captionHTML = '';
        if (currentSlideElement) {
          const hiddenCaption = currentSlideElement.querySelector('.hidden-caption-content');
          if (hiddenCaption) {
            // get caption from element with class hidden-caption-content
            captionHTML = hiddenCaption.innerHTML;
          } else {
            // get caption from alt attribute
            captionHTML = currentSlideElement.querySelector('img').getAttribute('alt');
          }
        }
        el.innerHTML = captionHTML || '';
      });
    }
  });
})

lightbox.init()
