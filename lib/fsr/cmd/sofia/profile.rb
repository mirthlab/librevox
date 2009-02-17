require "fsr/app"
module FSR
  module Cmd
    class Sofia 
      class Profile < Command
        attr_reader :fs_socket, :raw_string

        def initialize(fs_socket = nil, args = nil)
          @fs_socket = fs_socket # FSR::CommandSocket object
          @raw_string = args # If user wants to send a raw "sofia profile"
        end

        # Send the command to the event socket, using api by default.
        def run(api_method = :api)
          orig_command = "%s %s" % [api_method, raw]
          Log.debug "saying #{orig_command}"
          @fs_socket.say(orig_command)
        end

        # Start a sip_profile
        def start(profile)
          Profile.new(@fs_socket, "#{profile} start")
        end

        # Restart a sip_profile
        def restart(profile)
          Profile.new(@fs_socket, "#{profile} restart")
        end

        # Stop a sip_profile
        def stop(profile)
          Profile.new(@fs_socket, "#{profile} stop")
        end

        # Rescan a sip_profile
        def rescan(profile)
          Profile.new(@fs_socket, "#{profile} rescan")
        end


        # This method builds the API command to send to the freeswitch event socket
        def raw
          unless @raw_string.nil? or @raw_string.empty?
            orig_command = "sofia profile #{@raw_string}"
          else
            orig_command = "sofia profile"
          end
        end
      end
    end
  end
end
