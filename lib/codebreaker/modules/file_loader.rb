# frozen_string_literal: true

# Codebreaker namespace module
module Codebreaker
  # #save() -- saves raw objects into .yml
  # .load -- loads raw objects
  module FileLoader
    # DB_PATH = "#{Pathname(__FILE__).parent.dirname.realpath}/db/"

    # FILE_PATH = "#{DB_PATH}#{ENV['DB_FILE']}"
    FILE_PATH = "#{ENV['DB_PATH']}#{ENV['DB_FILE']}"

    def self.included(base)
      base.extend(ClassMethods)
    end

    # class method load
    module ClassMethods
      def load
        raise Codebreaker::Validation::NoSavedData, 'No saved data is found' unless File.exist? FILE_PATH

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
