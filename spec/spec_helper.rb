$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require "chartmogul"

def restore_default_config
  Chartmogul.configuration = nil
  Chartmogul.configure {}
end
