module Ricer4::Plugins::Admin
  class Raw < Ricer4::Plugin
    
    trigger_is :raw

    permission_is :responsible
    
    has_usage  '<message>'
    def execute(message)
      server.connector.send_raw(message)
    end
    
  end
end
