UnitRecord
==========

Enables unit testing ActiveRecord classes without hitting the database.

Why?
----

Rationale: [http://www.dcmanges.com/blog/rails-unit-record-test-without-the-database](http://www.dcmanges.com/blog/rails-unit-record-test-without-the-database)

The biggest benefit to disconnecting unit tests from the database is having a faster test suite.  Here is the benchmark from one of my current projects:

    Finished in 19.302702 seconds.
    4920 tests, 7878 assertions, 0 failures, 0 errors
  
4 seconds per 1,000 tests is a good guideline.

Installation
------------

    gem install unit_record

Usage
-----

Restructuring the Rails Test Directory
--------------------------------------

The Rails test directory typically places testing for models under <tt>test/unit</tt> and tests for controllers under <tt>test/functional</tt>.  However, we need to change the definition of unit and functional.  Controllers can be unit tested (mocking out models and not rendering the view).  Models can be functionally tested (hitting the database).  Also, each type of test needs its own test\_helper.  I recommend restructuring your test directory like this:

    test
      test_helper.rb
      unit
        unit_test_helper.rb
        controllers
        models
      functional
        functional_test_helper.rb
        controllers
        models

You should move existing functional tests into functional/controllers.  You will also need to change the require line at the top of those tests to require the functional\_test\_helper.rb file instead of the test\_helper.rb file.

The <tt>functional_test_helper.rb</tt> file only needs to require <tt>test_helper.rb</tt>:

    require File.dirname(__FILE__) + "/../test_helper"

For moving unit tests, you have a few options.  I recommend moving them to unit/models and then disconnecting your unit tests from the database.  Any tests that fail should then be modified to not hit the database or moved to functional/models.

Disconnecting
-------------

In the <tt>test/unit/unit\_test\_helper.rb</tt> file you created when restructuring your test directory, you should add these lines:

    require File.dirname(__FILE__) + "/../test_helper"
    require "unit_record"
    ActiveRecord::Base.disconnect!
  
The <tt>disconnect!</tt> method will do everything necessary to run your unit tests without hitting the database.

Development
-----------

Active development occurs on the [GitHub](http://github.com/dan-manges/unit-record). Changes are pushed to the Rubyforge git repository.

Thanks
------
Thanks to Jay Fields for the [original implementation](http://blog.jayfields.com/2007/03/rails-activerecord-unit-testing-part-ii.html).

Maintainer
----------

[Dan Manges](http://www.dcmanges.com)

Contributors
------------

* David Lowenfels
* Rob Sanheim

License
-------
Released under the MIT license
