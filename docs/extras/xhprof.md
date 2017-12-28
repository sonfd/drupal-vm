[XHProf](http://xhprof.io/) allows easy code profiling and can be used in many different ways. Ensure `xhprof` is in the list of `installed_extras` inside `config.yml`.

<<<<<<< HEAD
_Note: XHProf does currently not work with PHP 7.1+. The PHP extension has barely been maintained since Facebook abandoned the project around 2015, so it's difficult to get it running under newer versions of PHP. If you require support for PHP 7.1 or newer, you should use [Tideways](tideways.md) instead._
=======
_Note: XHProf does currently not work with PHP 7.1. The PHP extension has barely been maintained since Facebook abandoned the project around 2015, so it's difficult to get it running under newer versions of PHP. If you require support for PHP 7.1 you should use [Tideways](tideways.md) instead._
>>>>>>> dd747fad95dbf3b776a00731ba9641b7f5e76343

### XHProf module

The easiest way to use XHProf to profile your PHP code on a Drupal site is to install the [XHProf](https://www.drupal.org/project/xhprof) module, then in XHProf's configuration (at `/admin/config/development/xhprof`), check the 'Enable profiling of page views and drush requests' checkbox.

The XHProf module doesn't include built-in support for callgraphs, but there's an issue to [add callgraph support](https://www.drupal.org/node/1470740).

<<<<<<< HEAD
You can view callgraphs (and a listing of all stored runs) using Drupal VM's own XHProf installation by visiting [http://xhprof.drupalvm.test/](http://xhprof.drupalvm.test) and clicking on the relevant run, then clicking the _[View Full Callgraph]_ link.
=======
You can view callgraphs (and a listing of all stored runs) using Drupal VM's own XHProf installation by visiting [http://xhprof.drupalvm.dev/](http://xhprof.drupalvm.dev) and clicking on the relevant run, then clicking the _[View Full Callgraph]_ link.
>>>>>>> dd747fad95dbf3b776a00731ba9641b7f5e76343

### Devel module (deprecated)

The Devel module also *used* to provide XHProf configuration, and setting the options below would allow Devel's XHProf integration to work correctly with Drupal VM's XHProf installation:

  - **xhprof directory**: `/usr/share/php`
<<<<<<< HEAD
  - **XHProf URL**: `http://xhprof.drupalvm.test`
=======
  - **XHProf URL**: `http://xhprof.drupalvm.dev`
>>>>>>> dd747fad95dbf3b776a00731ba9641b7f5e76343

**Note**: You should only enable one code profiler at a time—e.g. when using [Blackfire](blackfire.md), disable [XHProf](xhprof.md), [Tideways](tideways.md) and [XDebug](xdebug.md).
