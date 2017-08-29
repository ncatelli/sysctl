resource_name :sysctl_set

default_action :set

property :key, String, name_property: true
property :value, String, required: true

def exists?(resource)
  cmd = Mixlib::ShellOut.new("#{node['sysctl']['bin']} #{resource.key}")
  cmd.run_command
  begin
    cmd.error!
    if cmd.stdout.strip.eql? "#{resource.key} = #{resource.value}"
      true
    else
      false
    end
  rescue
    false
  end
end

action :set do
  unless exists?(new_resource)
    execute "set sysctl #{new_resource.key}: #{new_resource.value}" do
      command "#{node['sysctl']['bin']} -w #{new_resource.key}=#{new_resource.value}"
      action :run
    end

    file "#{node['sysctl']['path']}/#{new_resource.key}.conf" do
      content "#{new_resource.key}=#{new_resource.value}"
      owner 'root'
      group 'root'
      mode '0644'
      action :create
    end
  end
end
