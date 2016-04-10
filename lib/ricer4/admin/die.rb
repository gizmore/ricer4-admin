module Ricer4::Plugins::Admin
  class Die < Ricer4::Plugin

    trigger_is :die
    permission_is :owner
    
    requires_retype

    has_usage
    has_usage '<message>'
    def execute(message=nil)
      bot.running = false
      bot.servers.online.each do |server|
        server.localize!.connector.send_quit(message||default_quit_message)
      end
    end
    
    def default_quit_message
      t :default_message, user: sender.display_name
    end
    
  end
end
