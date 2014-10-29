## Fulcrum Photo Importer

This program takes a list of photo files as input and uploads them to your Fulcrum account.

### Setup

```sh
bundle --path .bundle
```

### Running

```sh
./import-photos.rb import --token=$API_TOKEN --file=/path/to/photos.csv [--skip=0]
```

### Parameters

```
--token : Fulcrum API token
--file  : path to file containing a list of files you want to upload
--skip  : (option, default 0) the number of lines to skip in the file (if you stop the script and continue later)
```

### Input File

The file containing the list of photo files is very simple. The file names can either be absolute file paths, or just file names of photos in the same directory as the input file. If the filenames are valid UUID's, it will use the UUID as the Fulcrum `access_key` for the photo.

Here is a sample file:

```
7fb4a6e4-6f70-46f4-a516-bc93721dea46.jpg
817cfc44-a3ca-4d89-9189-5eb0a6def12b.jpg
fa02c941-b435-4588-a415-6ca733689823.jpg
9058de2f-9480-45cd-a8c8-a904cab4b4a2.jpg
f3699c8f-c754-4d02-8ad1-b0c992ed3b98.jpg
e06a83be-a234-46a4-8e2c-3fffe8447d26.jpg
```
