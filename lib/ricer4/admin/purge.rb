module Ricer4::Plugins::Admin
  class Purge < Ricer4::Plugin

    trigger_is :purge
    permission_is :responsible

    requires_retype

    has_usage '<plugin>'
    def execute(plugin)
      byebug
      rply :msg_purging
      plugin.delete
      
      Ricer4::PluginLoader.new(bot).downgrade_plugin(plugin, 0)
      purge_plugin_rows(plugin)
      exec_newline('Admin/Die '+t(:msg_purged_and_die))
    end
    
    private
    
    ###
    ### Delete the plugin inside ricer core tables
    ### Hopefully triggers some other deletes, eg: PluginStats
    ### TODO: Test that
    ###
    def purge_plugin_rows(plugin)
      Ricer4::Plugin.where(:bot_id => bot.id).where('name LIKE ?', "#{plugin.plugin_module}/%").each do |p|
        byebug
        p.destroy!
        byebug
      end
    end
    
  end
end
