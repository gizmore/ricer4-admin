module Ricer4::Plugins::Admin
  class Reboot < Ricer4::Plugin
    
    trigger_is :reboot
    permission_is :responsible
    
    requires_retype
    
    has_usage and has_usage '<message>'
    def execute(message=nil)
      get_plugin('Admin/Die').execute(message||default_reboot_message)
      pid = spawn "bundle exec ricer"
      Process.detach(pid)
    end
    
    def default_reboot_message
      t(:default_msg, user: sender.display_name)
    end

  end
end
