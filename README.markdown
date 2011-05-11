Shortcomings of most current template engines (e.g. Liquid, Smarty):

* Authors must learn yet another syntax
* Needs custom parser to parse template code and therefore do not produce correct HTML output when viewed in browser as static files.

Design goals of this engine:

* Templates are pure and valid HTML5 files
* Template specific control flow is declared with element classes and "data-" attributes
* Can be written and tested 100% using normal static HTML authoring tools (Dreamweaver, Notepad etc)
* Does not need any parsers or renderers to see end-result in browser during template authoring
* To render templates on server-side, existing html parsing and dom-manipulating components can be used
* Template syntax has minimal footprint and is intuitive, does not need cheatsheet at hand to code

## Example

    <!doctype html>
    <html>
    <head>
      <title data-tpl-content="page.title"></title>
    </head>
    <body>
      <header>
      <nav data-tpl-for="menuitems">
        <a href="" data-tpl-attrs="{href: menuitem.href}" data-tpl-content="menuitem.title">Foo</a>
        <a href="" data-tpl-remove="true">Bar</a>
        <a href="" data-tpl-remove="true">Baz</a>
      </nav>
      </header>
      <div id="main" data-tpl-content="page.body">
        Body example that will be replaced with "page.body" assigned variable contents when rendering.
      </div>
      
      <div class="template-comment" data-tpl-remove="true">
        This is Template comment that will be removed during rendering thanks to its data-tpl-remove
        attribute.
      </div>
    </body>
    </html>

## Control flow functions

### if

    <div data-tpl-if="page.published">
      This div element will be shown only if page.published evaluates to true
    </div>
    
    <div data-tpl-contents-if="page.published">
      The contents of this div element will be shown only if page.published evaluates to true
    </div>

Evaluations would suck just a little bit

    <div data-tpl-if="3 == 3">True</div>
    # => <div>True</div>
    
    <div data-tpl-if="2 < 3">True</div>
    # => <div>True</div>
    
    <div data-tpl-if="2 > 3">False</div>
    # => <div>False</div>
    
    <div data-tpl-if="true || false">Dunno</div>
    # => <div>Dunno</div>

Think of more complex equations like "page.published or page.published > Date.today"

### for

Let

    things = ['Foo', 'Bar', 'Baz']

Template to render them in LI elements:

    <ul data-tpl-for="things">
      <li data-tpl-content="thing"></li>
    </ul>
    
    # => <ul><li>Foo</li><li>Bar</li><li>Baz</li></ul>

When variable assigned to for cycle is an array and named in plural form, it will automatically make variable available inside for scope with that name in singular form.

### case

### cycle

### include

    <div data-tpl-include="other.html"></div>

File other.html could be included over AJAX with javascript (and evaluated, if necessary).

### unless

Works the same way as if, only negates the evaluation

### assign

Assign "page.title" to variable "myvariable".

    <div data-tpl-assign-var="myvariable" data-tpl-assign-value="page.title"></div>

"data-tpl-remove" attribute can be used to remove current div tag (and all it's descendants) from rendering.

### capture

    <div data-tpl-capture="tovariable">
      Whatever evaluates out from this element, it will be stored in variable named "tovariable"
    </div>
    
    <!-- do some stuff and release capture in next element: -->
    
    <div data-tpl-content="tovariable"></div>

Again, "data-tpl-remove" tag could do some clean-up.

### comments

Use normal HTML comments. OR:

    <div data-tpl-remove="true">
      This is a comment too.
    </div>

## Filters

data-filter-attribute can be used

### truncate

    <div data-tpl-filter-truncate="15">This text is longer than 15 characters</div>
    # => <div>This text is...</div>

### replace

    <div data-tpl-filter-replace="Foo" data-tpl-filter="Bar">Foo Bar</div>
    # => <div>Bar bar</div>

"data-tpl-filter-ireplace" could be case-insensitive replace filter.

These are just examples of filters, more of them could be developed easily.

## Javascript

The example above can be easily rendered to full page even with javascript. Consider adding this script to the end of page:

    <script src="http://myhost.com/fantastic.template.renderer.js" />
    <script>
      var data = {
        menuitems = [
          {title: 'Home page', href: '/'},
          {title: 'Blog', href: '/blog'},
          {title: 'Contacts', href: '/contacts'}
        ],
        page = {
          title: 'Awesome page',
          body: 'Page body'
        }
      }
      TemplateRenderer.renderWith(data);
    </script>

Then this html file renders as

    <!doctype html>
    <html>
    <head>
      <title>Awesome page</title>
    </head>
    <body>
      <header>
      <nav>
        <a href="/">Home page</a>
        <a href="/blog">Blog</a>
        <a href="/contacts">Contacts</a>
      </nav>
      </header>
      <div id="main">Page body</div>
    </body>
    </html>

## Unresolved questions and shortcomings

Render attribute only under certain conditions:

    <a href=""
      data-tpl-attr-class-if="page.published"
      data-tpl-attr-class-val-if="published">Page link</a>
    # => <div class="published"></div>

Render part of attribute onlu under certain conditions:

    <a href="" class="menuitem"
      data-tpl-append-class-if="page.published"
      data-tpl-attr-append-class-val-if="published">Page link</a>
    # => <a href="" class="menuitem published">Page link</a>
