# Bootstrap, CSS, and Icons in this Site

## Bootstrap

This site uses Bootstrap for most of its CSS. I have Bootstrap to attribute to the site looking so nice. Here are the "elements" that I'm using from Bootstrap:

### Layout

My site is responsive because of [Bootstrap's responsive layout](https://getbootstrap.com/docs/4.0/layout/overview/) option! This is what determines the break-points to change the section margins and width size. I use the [Grid system](https://getbootstrap.com/docs/4.0/layout/grid/) to make the proper columns.

### Pagination

To make the pretty pagination bar appear on the blog pages, I use [Bootstrap's built-in pagination](https://getbootstrap.com/docs/4.0/components/pagination/) to create the CSS. Specifically, I use `disabled` and `active` states, as well as center-page alignment. See where I implement Bootstrap's pagination bar [here](https://github.com/emma-sax4/emma-sax4.github.io/blob/release/_includes/pagination.html). For the icons, I use [Feather Icons](https://github.com/feathericons/feather).

### Navbar

The responsive navbar utilized in this site is from [Bootstrap's built-in navbar](https://getbootstrap.com/docs/4.0/components/navbar/) option. Specifically, it uses the [Navbar](https://getbootstrap.com/docs/4.0/components/navbar/#nav) which is fully responsive on smaller screens, as well as the `Primary` color scheme shown [here](https://getbootstrap.com/docs/4.0/components/navbar/#color-schemes). I do add some custom icons to the drop-down section of the responsive navbar, as well as customizing the color and the font-styles. The navbar is in action [here](https://github.com/emma-sax4/emma-sax4.github.io/blob/release/_includes/header.html), and [here](https://github.com/emma-sax4/emma-sax4.github.io/blob/release/assets/css/_navigation.scss) is the overriding CSS for my navbar.

### Tables

For my tables on this site, I use [Bootstrap's built-in tables](https://getbootstrap.com/docs/4.0/content/tables/), which are responsive, as long as you use `class: "table-responsive"` at the top (read more about responsive tables [here](https://getbootstrap.com/docs/4.0/content/tables/#responsive-tables)). The tables I've selected to use is described in ['Hoverable Rows'](https://getbootstrap.com/docs/4.0/content/tables/#hoverable-rows). I use the tables in [this Markdown file](https://github.com/emma-sax4/emma-sax4.github.io/blob/release/_pages/around_town.md) and in [this Markdown file](https://github.com/emma-sax4/emma-sax4.github.io/blob/release/_posts_/2020-01-01-dns-domains-and-personal-websites.md). Because it's Markdown, it may be more helpful to view the 'Raw' code.

### Buttons

This site uses [Bootstrap's buttons](https://getbootstrap.com/docs/4.0/components/buttons/) for all of it's button functionality (unless the button is an icon). Here's a [button that I've made](https://github.com/emma-sax4/emma-sax4.github.io/blob/release/_includes/email_button.html) that uses Bootstrap's design but includes a Feather Icon. I prefer the look of the [Outline buttons](https://getbootstrap.com/docs/4.0/components/buttons/#outline-buttons) more than the solid ones, but that's just my preference.

## CSS

Using Bootstrap for the entire layout of this website, as well as for specific elements means there's so much less CSS in this repository. I started with over 600 lines of CSS, and now I have more like ___. But, there are still some pieces that I've chosen to override from Bootstrap's defaults. All of my custom CSS is in [this directory](https://github.com/emma-sax4/emma-sax4.github.io/tree/release/assets/css).

The pieces I'm overriding are:
* Blockquotes
* Preformatted monospace (like code snippets)
* Links and buttons
* Navbar settings and colors
* Other site settings
  * Font sizes and styles
  * `main-content` and `body` settings
  * Footer

## Icons

The site uses [Feather Icons](https://github.com/feathericons/feather) for all of its pretty icons, including the
* GitHub icon
* LinkedIn icon
* Twitter icon
* mail send icon
* forward/backward icons

Icons are called like this:
```html
<i data-feather="twitter"></i>
```

To make the icon into a button, you can write it in an `a href` tag:
```html
<a href="https://twitter.com/emma_sax4" target="_blank" class="link-icon">
  <i data-feather="twitter"></i>
</a>
```

The `link-icon` class is something that I've created with common link-icon settings. Read more about my custom CSS in the secton above.

Lastly, as long as these two lines are at the bottom of the file, the icons appear magically!
```html
<script src="https://unpkg.com/feather-icons"></script>
<script>feather.replace()</script>
```

See them in action [here](https://github.com/emma-sax4/emma-sax4.github.io/blob/release/_layouts/home.html#L20).

## Conclusion

Now that you've seen how Bootstrap and Feather Icons have improved my website, it's time for you to get started! Here are some potentially helpful links to get you on the right track:
* https://getbootstrap.com/
* https://github.com/feathericons/feather#2-include
