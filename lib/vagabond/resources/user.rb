module Vagabond
  module Resources
    class User < Resource
      attr_accessor :name, :group_ids, :group_names, :shell, :homedir

      def initialize(name, options={})
        @name = name
        `id #{name} 2> /dev/null`
        process_info = $?
        @exists = process_info.success?
        if @exists
          @group_ids   = `id -G #{name}`.split(/\s+/).map(&:to_i)
          @group_names = `id -Gn #{name}`.split(/\s+/)
          password_data = `cat /etc/passwd | awk -F ":" '$1 =="#{name}" {print}'`.chomp.split(/:/)
          @shell = password_data[6]
          @homedir = password_data[5]
        end
      end

      def exists?
        @exists
      end

      def member_of_group?(group)
        case group
        when String
          group_names.include? group
        when Numeric
          group_ids.include? group
        end
      end
    end
  end
end
