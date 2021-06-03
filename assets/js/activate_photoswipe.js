import PhotoSwipeLightbox from './photoswipe-lightbox.esm.min.js'

const lightbox = new PhotoSwipeLightbox({
  gallerySelector: ['.photoswipe-gallery', '.inner-photoswipe-gallery'],
  childSelector: '.photoswipe',
  pswpModule: '/assets/js/photoswipe.esm.min.js',
  pswpCSS: '/assets/css/photoswipe.min.css'
})

lightbox.init()
