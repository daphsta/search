# Zendesk Search

[![CircleCI](https://circleci.com/gh/daphsta/search.svg?style=svg)](https://circleci.com/gh/daphsta/search)
[![Maintainability](https://api.codeclimate.com/v1/badges/48dadc98a2cd19a97366/maintainability)](https://codeclimate.com/github/daphsta/search/maintainability)

A simple search application that allows searching through user provided .json files.
Users are able to search terms within a specified field.

## Requirements

The application is built and tested in `ruby 2.6.0` using `Bundler 2.0.1`

## Usage

To install gem dependencies, run
```
  bundle install
```

To run all tests
```
  rake rspec
```

To run the application
```
  ruby zendesk_search
```

More searchable `json` files can be added in the `data` folder

The application displays a selection of files to search from.
Then, the user is prompted to select from a list of fields to search.
The final prompt will get a search value from the user.

## Design

I have defined the following classes with specific namespaces:

* `DataRepository` - a data layer that mediates between the entities(`SearchEngine`)
                    and the actual data, in this case is a JSON file. This layer can eventually
                    evolve to take in an adapter that is responsible for converting raw data into a required
                    format, such as JSON. All queries for data is extended in this layer.
                    It exposes `fetch_all` which returns all data and `list_all_fields` which lists fields
                    in the specific file.
                    Having this boundary enables persistence and other objects to evolve independently.

* `SearchEngine` - responsible to perform searches given a search field and a search value.
                   It is an agnostic entity that is not tied to any specific application, in this case ZendeskSearch.
                   A data repository is injected into the `SearchEngine` to search within a specific data source.
                   `SearchEngine` only know how to retrieve data depending on query methods provided through
                   the data repository's interface.

* `ZendeskSearch` - responsible for the interaction of commands from prompts. This entity loads all prompts and delegates
                    resposibilities to a specific command. `ZendeskSearch` is very specific to the application.

* `Commands` module - all command modules take in a prompter to output to the CLI and receive user inputs from the CLI.
                      Each action is a single class to provide clarity and maintainability. Commands also interacts with
                      other entities such as instantiating the `DataRepository` and `SearchEngine`. `Commands` can be
                      thought of as the presentation layer.

* `SearchValueTypes` module - responsible for determining data types from the user input which is a `string`.
                              The `converter` is a factory that determines the class to convert the search value to.

## Limitations

* search is only performed on full text match
* only search on a single search field and value pair
* search is only scoped to a single file instead of across all files

## Further enhancement

This is a list of enhancements that could further improve the application given more time and resources:

* add a method to the `DataRepository` interface to accept multiple field, value pair to search.
  Example: repository.where(name: 'Eth').where(age: 32) would search for data that matches the conditions

* stream JSON for huge files that won't fit in memory. Gems like `JSON::Stream` or `yajl-ruby` would be useful
  to enable the application to handle bigger files

* pagination when displaying search data

* add more tests for coverage
