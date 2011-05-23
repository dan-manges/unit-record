UnitRecord
==========

Enables unit testing ActiveRecord classes without hitting the database.

Why?
----

Rationale: [http://www.dcmanges.com/blog/rails-unit-record-test-without-the-database](http://www.dcmanges.com/blog/rails-unit-record-test-without-the-database)

One of the biggest benefits to disconnecting unit tests from the database is having a faster test suite.  Here is the benchmark from one of my current projects:

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

Usage
-----

In the <tt>test/unit/unit\_test\_helper.rb</tt> file you created when restructuring your test directory, you should add these lines:

    require File.dirname(__FILE__) + "/../test_helper"
    require "unit_record"
    ActiveRecord::Base.disconnect!

The <tt>disconnect!</tt> method will do everything necessary to run your unit tests without hitting the database.

Strategy
--------

There are two options for what should happen if you hit the database. You can either have UnitRecord raise an exception, or simply no-op. Raising an exception can help identify why a test is failing, but it also may be inconvenient to work around.

If you want to raise an exception:

    ActiveRecord::Base.disconnect! :strategy => :raise

    Person.find(:all)
    #=> RuntimeError: ActiveRecord is disconnected; database access is unavailable in unit tests.

If you want to no-op:

    ActiveRecord::Base.disconnect! :strategy => :noop

    Person.find(:all)
    #=> []

You can also change strategies within a block:

    ActiveRecord::Base.connection.change_strategy(:raise) do
      Person.find(:all)
      #=> RuntimeError: ActiveRecord is disconnected; database access is unavailable in unit tests.
    end

    ActiveRecord::Base.connection.change_strategy(:noop) do
      Person.find(:all)
      #=> []
    end

Association Stubbing
--------------------

One painful aspect of unit testing ActiveRecord classes is setting associations. Because Rails does type checking when setting an association, you'll receive an exception if you try to use a stub in place of the expected class.

    Pet.new :owner => stub("person")
    #=> ActiveRecord::AssociationTypeMismatch: Person(#16620740) expected, got Mocha::Mock(#11567340)

If you're using mocha, you can have UnitRecord stub associations. To enable association stubbing:

    ActiveRecord::Base.disconnect! :stub_associations => true

The above example would no longer raise an exception. It would be the equivalent of:

    pet = Pet.new
    pet.stubs(:owner).returns(stub("person"))

Note that using this approach, the setter for the association will not work for that instance.

Development
-----------

Active development occurs on the [GitHub](http://github.com/dan-manges/unit-record). Changes are also pushed to the Rubyforge git repository.

For bugs/patches/etc please use the [Rubyforge tracker](http://rubyforge.org/tracker/?group_id=4239).

Continuous integration is provided by [RunCodeRun](http://runcoderun.com/dan-manges/unit-record).

Thanks
------
Thanks to Jay Fields for the [original implementation](http://blog.jayfields.com/2007/03/rails-activerecord-unit-testing-part-ii.html).

Maintainer
----------

[Dan Manges](http://www.dcmanges.com)

Contributors
------------

* Arvind Laxminarayan
* David Lowenfels
* Rob Sanheim

License
-------
Released under the MIT license

