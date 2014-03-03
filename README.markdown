# STCK Clinic #

Mostly-internal app for care facilities involved with
[So They Can Know](https://www.sotheycanknow.org)

[![Build Status](https://travis-ci.org/SexualHealthInnovations/stck-clinic.png?branch=master)](https://travis-ci.org/SexualHealthInnovations/stck-clinic)

[![Code Climate](https://codeclimate.com/github/SexualHealthInnovations/stck-clinic.png)](https://codeclimate.com/github/SexualHealthInnovations/stck-clinic)

[![Dependency Status](https://gemnasium.com/SexualHealthInnovations/stck-clinic.png)](https://gemnasium.com/SexualHealthInnovations/stck-clinic)

## Getting Started ##

This should help you get up and running to develop on this project:

### Requirements ###
* [PostgreSQL](http://www.postgresql.org/)
* http://ruby-lang.org 2.0.0 / 2.1.0 (ideally [RVM](http://rvm.io))
* Git

### Installation ###
1. Install rvm and ruby 2.1.0
1. Install PostgreSQL
1. Check out git repo locally
1. `bundle install`
1. `rake spec`

### Generate docs ###

We use [Yardoc](http://yardoc.org/) for documentation so please feel
free to generate docs by running `yard` and checking in the `doc`
folder for output.

## Contributing ##

Pull requests welcome! Please make sure you've got rspec coverage for
your contributions (this includes feature specs for frontend
stuff!). SimpleCov reports generated in the `coverage` folder will
help you make sure you've got adequate spec coverage.

### Other ideas ###

Provide a Vagrant config to ease development.

Copyleft 2014 Sexual Health Innovations
http://sexualhealthinnovations.org
