#!/usr/bin/env ruby

require 'bundler/setup'
require 'thor'
require 'json'
require 'fulcrum'
require 'csv'
require 'colorize'

Bundler.setup(:default)

VALID_UUID = /\A([0-9a-fA-F]{32}|[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12})\z/

class Import < Thor
  desc "import", "import photos"
  method_option :token, type: :string, required: true
  method_option :file,  type: :string, required: true
  method_option :skip,  type: :numeric, default: 0
  def import
    client = Fulcrum::Client.new(options[:token])

    file_root = File.dirname(options[:file])

    photos = []

    CSV.foreach(options[:file]) do |row|
      photos << row[0]
    end

    photos.each_with_index do |photo_file, index|
      line = index + 1

      if index < options[:skip]
        log line, "#{'Skipping'.red} #{photo_file}"
        next
      end

      if File.exist?(photo_file)
        # absolute path
        file_path = photo_file
      else
        # file name relative to input csv file
        file_path = File.join(file_root, photo_file)
      end

      if !File.exist?(file_path)
        log line, "#{'Skipping'.red} #{photo_file} because it doesn't exist"
        next
      end

      id = File.basename(file_path, '.*')
      id = SecureRandom.uuid unless id =~ VALID_UUID

      log line, "#{'Creating'.green} #{photo_file}"

      client.photos.create(file_path, 'image/jpeg', access_key: id)
    end
  end

  no_tasks do
    def log(line_number, message)
      puts "#{line_number.to_s.blue} : #{message}"
    end
  end
end

Import.start
