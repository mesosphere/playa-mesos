require 'json'
require 'pathname'

class PlayaSettings
  attr_reader :settings_file

  def initialize(settings_file)
    @settings_file = settings_file
    @settings = read_user_settings(settings_file)
  end

  def method_missing(sym, *args, &block)
    if @settings.include?(sym.to_s)
      return @settings[sym.to_s]
    else
      super(sym, *args, &block)
    end
  end

  def respond_to?(sym, include_private = false)
    @settings.include?(sym.to_s) || super(sym, include_private)
  end

  # Return the path of the settings_file
  def settings_path
    File.dirname(settings_file)
  end

  private

  def read_user_settings(settings_file)
    remove_nils(JSON.load(File.open(settings_file)))
  rescue
    {}
  end

  def remove_nils(hash)
    hash.delete_if { |k, v| v.nil? }
  end
end
