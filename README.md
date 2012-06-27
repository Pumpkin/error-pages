# CloudApp Error Pages

A few simple error pages used by all CloudApp applications.


## Prerequisites

After cloning the repo, install the
[aws-sdk](https://github.com/amazonwebservices/aws-sdk-for-ruby) gem which is
mostly conveniently done using [bundler](https://github.com/carlhuda/bundler).

    $ git clone https://github.com/cloudapp/error-pages.git
    $ [sudo] gem install bundler
    $ bundle install


## Configuration

Error pages are deployed to an S3 bucket which will require, not surprisingly,
AWS credentials and a bucket name. Configure option using the example as a
template.

    $ cp aws_config.yml.example aws_config.yml


## Deploying

Synchronize the error pages on S3 with those in the `public` directory by
running the `deploy` rake task. Every key prefixed by `errors` will be deleted
and replaced by the files in `public`.

    $ rake deploy

    Clearing existing error assets...
    Uploading new error assets...
    Uploaded public/images/error-page-logo.png to https://s3.amazonaws.com/f.cl.ly/errors/images/error-page-logo.png
    Uploaded public/stylesheets/error.css to https://s3.amazonaws.com/f.cl.ly/errors/stylesheets/error.css
    Uploaded public/maintenance.html to https://s3.amazonaws.com/f.cl.ly/errors/maintenance.html
    Uploaded public/not-found.html to https://s3.amazonaws.com/f.cl.ly/errors/not-found.html
