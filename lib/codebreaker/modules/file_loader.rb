# frozen_string_literal: true

module Codebreaker
  class FileLoader
    include Validation

    FILE_PATH = "#{ENV['DB_PATH']}#{ENV['DB_FILE']}"

    def initialize(db_file_path = FILE_PATH)
      @db_file_path = db_file_path
    end

    def load
      validate_file_existens(FILE_PATH)

      File.open(FILE_PATH, 'r') do |file|
        YAML.load_stream(file)
      end
    end

    def save(object)
      create_directory('DB_PATH') unless Dir.exist?(ENV['DB_PATH'])
      File.open(FILE_PATH, 'a') { |file| file.write(object.to_yaml) }
    end

    def create_directory(path)
      Dir.mkdir(ENV[path])
    end
  end
end
