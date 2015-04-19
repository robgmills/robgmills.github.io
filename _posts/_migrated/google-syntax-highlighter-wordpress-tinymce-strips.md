# [Google Syntax Highlighter: Wordpress TinyMCE strips out HTML tags and attributes as Author](./google-syntax-highlighter-wordpress-tinymce-strips)
- 2012/02/03
- Technology

**UPDATE (7/12/2012 15:50):** I've since switched from the Google Syntax Highlighter plugin to the [SyntaxHighlighter Evolved plugin](http://www.viper007bond.com/wordpress-plugins/syntaxhighlighter/) which doesn't have this issue.  I should note, this syntax highlighting is an anchor on the website.  Disabling it speeds things up tremendously.  It'll have to be something I come back to address later.

I use the [Google Syntax Highlighter](http://alexgorbatchev.com/SyntaxHighlighter/) for [WordPress plugin](http://wordpress.org/extend/plugins/google-syntax-highlighter/) to markup my code snippets on this site.  Its simple to use, just wrap your code in

	<pre name="code" class="java"></pre>

elements and give it a [supported class](http://code.google.com/p/syntaxhighlighter/wiki/Languages to properly highlight whatever language it is you're posting.  And voila!  Your code looks pretty...well, *prettier*.

This works great if you're logged in as an Administrator.  However, I like to practice strict access control guidelines.  I only log into my Administrator account when I absolutely must administrate something: install a plugin, change a setting, create a user, or update plugins and Wordpress itself.  I'll come back to that last one in a bit.  The rest of the time, I log in as an Author.  Someone who doesn't have many more permissions other than to create the mindless drivel you're reading now.

Unfortunately, the TinyMCE-based editor Wordpress uses by default to create and edit posts has a few configuration options that prevent the Google Syntax Highlighter for Wordpress plugin from working as an Author.  Actually, the plugin works fine *if* you can get the editor to not remove the "name" and "class" attributes from your `<pre></pre>` elements.  What's happening is there's a list of approved elements and element attributes in the file `wp-includes/kses.php`.  In order to get them approved, open the file, find where they define the "pre" element (it's line 271 in Wordpress 3.3.1):

	'pre' =&gt; array(
		'style' =&gt; array(),
		'width' =&gt; array ()),

and add your two attribute names to the array, like so:

	'pre' =&gt; array(
		'style' =&gt; array(),
		'width' =&gt; array (),
		'name' =&gt; array(),
		'class' =&gt; array()),

Now you should be able to properly mark up your code using the plugin as an Author.  At least for the time being.  

Remember how I said one of the things I do as an Administrator is update Wordpress itself?  Well, the process of updating is really simple: you login an an Administrator, see the notification at the top of the Dashboard, click the link, and it downloads the new version and automatically installs it.  The problem comes when you've made edits to some of the core files of Wordpress, as I've done to `wp-includes/kses.php`.  The file gets overwritten and you're back where you started.  I'm still looking for a plugin that should prevent this from happening.  The plugin would use the appropriate hook to bypass the configuration in the core file and wouldn't get overwritten on an update.  But so far, no luck.  For now, every time I update, I now have to remember to re-edit the file.
