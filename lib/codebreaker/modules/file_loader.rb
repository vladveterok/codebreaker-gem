# frozen_string_literal: true

# top-level descriptive comment here
module Codebreaker
  # top-level descriptive comment here
  module FileLoader
    DB_FILE_NAME = 'results.yaml'
    DB_FILE_PATH = "./db/#{DB_FILE_NAME}"

    def self.included(base)
      base.extend(ClassMethods)
    end

    # class method load
    module ClassMethods
      def load
        return unless File.exist? DB_FILE_PATH

        File.open(DB_FILE_PATH, 'r') do |file|
          YAML.load_stream(file)
        end
      end
    end

    def save(user)
      Dir.mkdir('./db') unless Dir.exist?('./db')
      File.open(DB_FILE_PATH, 'a') { |file| file.write(user.to_yaml) }
    end
  end
end
