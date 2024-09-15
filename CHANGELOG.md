# Changelog

## Version 0.3.0

* Added `BUNNYNET_SKIP_IF_EXISTS` environment variable to skip uploading if the file already exists on Bunny.net

## Version 0.2.0

* Added configurable Bunny.net storage URL option
* Introduced `BUNNYNET_STORAGE_URL` environment variable
* Updated `bunnynet_url` and `flush_deletes` methods to use the configurable storage URL
* Added documentation for the new storage URL configuration option
* Updated README.md and .env.example to include the new storage URL option

## Version 0.1.0

* Initial release of paperclip-bunnynet
* Replaced Dropbox integration with Bunny.net storage support
* Added support for Bunny.net API key, storage zone, and CDN URL configuration
* Updated documentation and README for Bunny.net integration
