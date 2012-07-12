# git-timesheet

A tool to generate your timesheet from a git log. Put it in your `~/bin`!

    $ git-timesheet.rb --help
    Usage: git-timesheet [options]
        -s, --since [TIME]               Start date for the report (default is 1 week ago)
        -a, --author [EMAIL]             User for the report (default is the author set in git config)
            --authors                    List all available authors

## Changelog

**2012-07-12** forced encoding to avoid errors in Ruby 1.9

* * *

(c) 2011-2012 [Leonid Shevtsov](http://leonid.shevtsov.me)

