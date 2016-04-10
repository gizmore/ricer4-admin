module Ricer4::Plugins::Admin
  class Upgrade < Ricer4::Plugin
    
    trigger_is :upgrade
    permission_is :responsible

    requires_retype
    
    has_usage
    def execute
      rply :msg_pulling
      threaded {
        reply `git reset --hard origin/master && git pull && git reset --hard origin/master`
      }
    end

  end
end
