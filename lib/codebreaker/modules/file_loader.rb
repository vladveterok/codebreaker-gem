# frozen_string_literal: true

# top-level descriptive comment here
module FileLoader
  LIB_FILE_NAME = 'lib.yaml'

  def self.included(base)
    base.extend(ClassMethods)
  end

  # class method load
  module ClassMethods
    def load
      return unless File.exist? "db/#{LIB_FILE_NAME}"

      File.open("./db/#{LIB_FILE_NAME}", 'r') do |file|
        YAML.load_stream(file)
      end
    end
  end

  def save(user)
    File.open("./db/#{LIB_FILE_NAME}", 'a') { |file| file.write(user.to_yaml) }
  end
end
