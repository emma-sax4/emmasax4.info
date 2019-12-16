# Writing Markdown Tables for this Website

This reference is designed to help authors of this repository write tables that will be compatible both on https://emmasax4.info and on GitHub.

## TL;DR

### Writing Tables without Headers

#### The Code

```markdown
<!-- Add an empty header row so the table renders correctly on GitHub Markdown -->

|                 |                 |                 |
| --------------- | --------------- | --------------- |
| Test column 1.0 | Test column 2.0 | Test column 3.0 |
| Test column 1.1 | Test column 2.1 | Test column 3.1 |
| Test column 1.2 | Test column 2.2 | Test column 3.2 |
| Test column 1.3 | Test column 2.3 | Test column 3.3 |
| Test column 1.4 | Test column 2.4 | Test column 3.4 |
```
#### On https://emmasax4.info

![image](https://user-images.githubusercontent.com/7562793/69976957-7b80cf80-14ef-11ea-9a0d-fc17af0813ea.png)

#### On GitHub

|                 |                 |                 |
| --------------- | --------------- | --------------- |
| Test column 1.0 | Test column 2.0 | Test column 3.0 |
| Test column 1.1 | Test column 2.1 | Test column 3.1 |
| Test column 1.2 | Test column 2.2 | Test column 3.2 |
| Test column 1.3 | Test column 2.3 | Test column 3.3 |
| Test column 1.4 | Test column 2.4 | Test column 3.4 |

### Writing Tables with Headers

#### The Code

```markdown
<!-- Add an empty header row so the table renders correctly on GitHub Markdown -->

|                              |                              |                              |
| ---------------------------- | ---------------------------- | ---------------------------- |
| **<center>Title 1</center>** | **<center>Title 2</center>** | **<center>Title 3</center>** |
| Test column 1.0              | Test column 2.0              | Test column 3.0              |
| Test column 1.1              | Test column 2.1              | Test column 3.1              |
| Test column 1.2              | Test column 2.2              | Test column 3.2              |
| Test column 1.3              | Test column 2.3              | Test column 3.3              |
| Test column 1.4              | Test column 2.4              | Test column 3.4              |
```

#### On https://emmasax4.info

![image](https://user-images.githubusercontent.com/7562793/69977161-e3371a80-14ef-11ea-98b5-58a7f8312e03.png)

#### On GitHub

|                              |                              |                              |
| ---------------------------- | ---------------------------- | ---------------------------- |
| **<center>Title 1</center>** | **<center>Title 2</center>** | **<center>Title 3</center>** |
| Test column 1.0              | Test column 2.0              | Test column 3.0              |
| Test column 1.1              | Test column 2.1              | Test column 3.1              |
| Test column 1.2              | Test column 2.2              | Test column 3.2              |
| Test column 1.3              | Test column 2.3              | Test column 3.3              |
| Test column 1.4              | Test column 2.4              | Test column 3.4              |

## The Long Version

All of the tables on this website so far are designed to be header-free. This is merely because my use of the tables so far don't require a header... in fact adding a header would almost make them more complicated.

In order for the tables to correctly display on GitHub, I've put in an empty header line to make the table show properly:
```markdown
<!-- Add an empty header row so the table renders correctly on GitHub Markdown -->
|                 |                 |                 |
| --------------- | --------------- | --------------- |
| Test column 1.0 | Test column 2.0 | Test column 3.0 |
| Test column 1.1 | Test column 2.1 | Test column 3.1 |
| Test column 1.2 | Test column 2.2 | Test column 3.2 |
| Test column 1.3 | Test column 2.3 | Test column 3.3 |
| Test column 1.4 | Test column 2.4 | Test column 3.4 |
```

So, on GitHub, this table shows up like this:

|                 |                 |                 |
| --------------- | --------------- | --------------- |
| Test column 1.0 | Test column 2.0 | Test column 3.0 |
| Test column 1.1 | Test column 2.1 | Test column 3.1 |
| Test column 1.2 | Test column 2.2 | Test column 3.2 |
| Test column 1.3 | Test column 2.3 | Test column 3.3 |
| Test column 1.4 | Test column 2.4 | Test column 3.4 |

That empty header row that shows up at the top is acceptable for me... I don't particularly mind if that's there on GitHub. The site is designed to be viewed fully online anyway—viewing my site's pages on GitHub is an added bonus. Therefore, I've added the following CSS to my site to make that disappear:
```css
th {
  font-weight: bold;
  padding: 0px;
  font-size: 0px;
  border: 0px solid #e9ebec;
}
```
What this does is guarantee that the header row will never have any border, and will not be of any size. So, on the website, it looks like there is no header. So this is how the above table will render online:

![image](https://user-images.githubusercontent.com/7562793/69976957-7b80cf80-14ef-11ea-9a0d-fc17af0813ea.png)

Much nicer!

But then the question arises... what if I _want_ some tables to have a header, and some not to?

Well the easy answer is that my custom CSS and ability to write tables however I want to make that easy. This piece of code makes the desired outcome on the website:
```markdown
<!-- Add an empty header row so the table renders correctly on GitHub Markdown -->
|                              |                              |                              |
| ---------------------------- | ---------------------------- | ---------------------------- |
| **<center>Title 1</center>** | **<center>Title 2</center>** | **<center>Title 3</center>** |
| Test column 1.0              | Test column 2.0              | Test column 3.0              |
| Test column 1.1              | Test column 2.1              | Test column 3.1              |
| Test column 1.2              | Test column 2.2              | Test column 3.2              |
| Test column 1.3              | Test column 2.3              | Test column 3.3              |
| Test column 1.4              | Test column 2.4              | Test column 3.4              |
```

![image](https://user-images.githubusercontent.com/7562793/69977161-e3371a80-14ef-11ea-98b5-58a7f8312e03.png)

But on GitHub, it becomes this:

|                              |                              |                              |
| ---------------------------- | ---------------------------- | ---------------------------- |
| **<center>Title 1</center>** | **<center>Title 2</center>** | **<center>Title 3</center>** |
| Test column 1.0              | Test column 2.0              | Test column 3.0              |
| Test column 1.1              | Test column 2.1              | Test column 3.1              |
| Test column 1.2              | Test column 2.2              | Test column 3.2              |
| Test column 1.3              | Test column 2.3              | Test column 3.3              |
| Test column 1.4              | Test column 2.4              | Test column 3.4              |

AKA, the centering of the "header"/first row doesn't actually work. There are a couple other alternatives of things I could do to make the centering come out on GitHub properly, but either way, that empty top row that doesn't go away would still exist.

So, at the end of the day I've decided to be OK with any table with a "header" to read like that on GitHub (with the empty header row on top, and the "header"/first row being left-aligned). As stated earlier, the website is designed to be read fully online at [https://emmasax4.info](https://emmasax4.info)—the ability to read the pages on GitHub is just a bonus.
