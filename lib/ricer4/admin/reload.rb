module Ricer4::Plugins::Admin
  class Reload < Ricer4::Plugin
    
    trigger_is :reload
#    permission_is :responsible
#    requires_confirmation

    has_usage and has_usage '<boolean|named:"install_plugins">'
    def execute(install_plugins=false)
      instant_reply(t(:msg_reloading))
#      threaded do
        sleep 0.2
        execute_reload(install_plugins)
        rply :msg_reloaded
#      end
    end
    
    def execute_reload(install_plugins)

      # Try to reload core
      Ricer4::Core::Init.reload_core
      # Try to reload plugins
      bot.loader.reload_plugins
      # Clear registered vars and handlers

      # Reload core again
      clear_plugin_class_variables
      arm_publish("ricer/reload")

      Ricer4::Core::Init.reload_core
      # Reload plugins again
      bot.loader.reload_plugins
      bot.loader.install if install_plugins
      bot.loader.init_plugins
      arm_publish("ricer/reloaded")
    end
    
    private
    
    def clear_plugin_class_variables
      Ricer4::Event.reset
      bot.loader.plugins.each do |plugin|
        plugin.clear_class_variables
      end
    end

  end
end