# frozen_string_literal: true

module Codebreaker
  module FileLoader
    FILE_PATH = "#{ENV['DB_PATH']}#{ENV['DB_FILE']}"

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      include Validation
      def load
        validate_file_existens(FILE_PATH)

        File.open(FILE_PATH, 'r') do |file|
          YAML.load_stream(file)
        end
      end
    end

    def save(object)
      Dir.mkdir(ENV['DB_PATH']) unless Dir.exist?(ENV['DB_PATH'])
      File.open(FILE_PATH, 'a') { |file| file.write(object.to_yaml) }
    end
  end
end
