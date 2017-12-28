# -*- mode: ruby -*-
# vi: set ft=ruby :

require_relative 'lib/drupalvm/vagrant'

# Absolute paths on the host machine.
host_drupalvm_dir = File.dirname(File.expand_path(__FILE__))
host_project_dir = ENV['DRUPALVM_PROJECT_ROOT'] || host_drupalvm_dir
host_config_dir = ENV['DRUPALVM_CONFIG_DIR'] ? "#{host_project_dir}/#{ENV['DRUPALVM_CONFIG_DIR']}" : host_project_dir

# Absolute paths on the guest machine.
guest_project_dir = '/vagrant'
guest_drupalvm_dir = ENV['DRUPALVM_DIR'] ? "/vagrant/#{ENV['DRUPALVM_DIR']}" : guest_project_dir
guest_config_dir = ENV['DRUPALVM_CONFIG_DIR'] ? "/vagrant/#{ENV['DRUPALVM_CONFIG_DIR']}" : guest_project_dir

drupalvm_env = ENV['DRUPALVM_ENV'] || 'vagrant'

<<<<<<< HEAD
default_config_file = "#{host_drupalvm_dir}/default.config.yml"
unless File.exist?(default_config_file)
  raise_message "Configuration file not found! Expected in #{default_config_file}"
=======
# Cross-platform way of finding an executable in the $PATH.
def which(cmd)
  exts = ENV['PATHEXT'] ? ENV['PATHEXT'].split(';') : ['']
  ENV['PATH'].split(File::PATH_SEPARATOR).each do |path|
    exts.each do |ext|
      exe = File.join(path, "#{cmd}#{ext}")
      return exe if File.executable?(exe) && !File.directory?(exe)
    end
  end
  nil
end

def get_ansible_version(exe)
  /^[^\s]+ (.+)$/.match(`#{exe} --version`) { |match| return match[1] }
end

def walk(obj, &fn)
  if obj.is_a?(Array)
    obj.map { |value| walk(value, &fn) }
  elsif obj.is_a?(Hash)
    obj.each_pair { |key, value| obj[key] = walk(value, &fn) }
  else
    obj = yield(obj)
  end
end

require 'yaml'
# Load default VM configurations.
vconfig = YAML.load_file("#{host_drupalvm_dir}/default.config.yml")
# Use optional config.yml and local.config.yml for configuration overrides.
['config.yml', 'local.config.yml', "#{drupalvm_env}.config.yml"].each do |config_file|
  if File.exist?("#{host_config_dir}/#{config_file}")
    optional_config = YAML.load_file("#{host_config_dir}/#{config_file}")
    vconfig.merge!(optional_config) if optional_config
  end
>>>>>>> dd747fad95dbf3b776a00731ba9641b7f5e76343
end

vconfig = load_config([
  default_config_file,
  "#{host_config_dir}/config.yml",
  "#{host_config_dir}/#{drupalvm_env}.config.yml",
  "#{host_config_dir}/local.config.yml"
])

provisioner = vconfig['force_ansible_local'] ? :ansible_local : vagrant_provisioner
if provisioner == :ansible
  playbook = "#{host_drupalvm_dir}/provisioning/playbook.yml"
  config_dir = host_config_dir
else
  playbook = "#{guest_drupalvm_dir}/provisioning/playbook.yml"
  config_dir = guest_config_dir
end

# Verify version requirements.
require_ansible_version ">= #{vconfig['drupalvm_ansible_version_min']}"
Vagrant.require_version ">= #{vconfig['drupalvm_vagrant_version_min']}"

ensure_plugins(vconfig['vagrant_plugins'])

Vagrant.configure('2') do |config|
  # Set the name of the VM. See: http://stackoverflow.com/a/17864388/100134
  config.vm.define vconfig['vagrant_machine_name']

<<<<<<< HEAD
=======
provisioner = ansible_bin && !vconfig['force_ansible_local'] ? :ansible : :ansible_local
if provisioner == :ansible
  playbook = "#{host_drupalvm_dir}/provisioning/playbook.yml"
  config_dir = host_config_dir
else
  playbook = "#{guest_drupalvm_dir}/provisioning/playbook.yml"
  config_dir = guest_config_dir
end

if provisioner == :ansible && ansible_version < ansible_version_min
  raise Vagrant::Errors::VagrantError.new, "You must update Ansible to at least #{ansible_version_min} to use this version of Drupal VM."
end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
>>>>>>> dd747fad95dbf3b776a00731ba9641b7f5e76343
  # Networking configuration.
  config.vm.hostname = vconfig['vagrant_hostname']
  config.vm.network :private_network,
    ip: vconfig['vagrant_ip'],
    auto_network: vconfig['vagrant_ip'] == '0.0.0.0' && Vagrant.has_plugin?('vagrant-auto_network')

  unless vconfig['vagrant_public_ip'].empty?
    config.vm.network :public_network,
      ip: vconfig['vagrant_public_ip'] != '0.0.0.0' ? vconfig['vagrant_public_ip'] : nil
  end

  # SSH options.
  config.ssh.insert_key = false
  config.ssh.forward_agent = true

  # Vagrant box.
  config.vm.box = vconfig['vagrant_box']

<<<<<<< HEAD
  # Display an introduction message after `vagrant up` and `vagrant provision`.
  config.vm.post_up_message = vconfig.fetch('vagrant_post_up_message', get_default_post_up_message(vconfig))
=======
  if vconfig.include?('vagrant_post_up_message')
    config.vm.post_up_message = vconfig['vagrant_post_up_message']
  else
    config.vm.post_up_message = 'Your Drupal VM Vagrant box is ready to use!'\
      "\n* Visit the dashboard for an overview of your site: http://dashboard.#{vconfig['vagrant_hostname']} (or http://#{vconfig['vagrant_ip']})"\
      "\n* You can SSH into your machine with `vagrant ssh`."\
      "\n* Find out more in the Drupal VM documentation at http://docs.drupalvm.com"
  end

  # If a hostsfile manager plugin is installed, add all server names as aliases.
  aliases = []
  if vconfig['drupalvm_webserver'] == 'apache'
    vconfig['apache_vhosts'].each do |host|
      aliases.push(host['servername'])
      aliases.concat(host['serveralias'].split) if host['serveralias']
    end
  else
    vconfig['nginx_hosts'].each do |host|
      aliases.concat(host['server_name'].split)
      aliases.concat(host['server_name_redirect'].split) if host['server_name_redirect']
    end
  end
  aliases = aliases.uniq - [config.vm.hostname, vconfig['vagrant_ip']]
  # Remove wildcard subdomains.
  aliases.delete_if { |vhost| vhost.include?('*') }
>>>>>>> dd747fad95dbf3b776a00731ba9641b7f5e76343

  # If a hostsfile manager plugin is installed, add all server names as aliases.
  aliases = get_vhost_aliases(vconfig) - [config.vm.hostname]
  if Vagrant.has_plugin?('vagrant-hostsupdater')
    config.hostsupdater.aliases = aliases
  elsif Vagrant.has_plugin?('vagrant-hostmanager')
    config.hostmanager.enabled = true
    config.hostmanager.manage_host = true
    config.hostmanager.aliases = aliases
  end

  # Sync the project root directory to /vagrant
  unless vconfig['vagrant_synced_folders'].any? { |synced_folder| synced_folder['destination'] == '/vagrant' }
    vconfig['vagrant_synced_folders'].push(
      'local_path' => host_project_dir,
      'destination' => '/vagrant'
    )
  end

  # Synced folders.
  vconfig['vagrant_synced_folders'].each do |synced_folder|
    options = {
<<<<<<< HEAD
      type: synced_folder.fetch('type', vconfig['vagrant_synced_folder_default_type']),
=======
      type: synced_folder.include?('type') ? synced_folder['type'] : vconfig['vagrant_synced_folder_default_type'],
      rsync__auto: 'true',
>>>>>>> dd747fad95dbf3b776a00731ba9641b7f5e76343
      rsync__exclude: synced_folder['excluded_paths'],
      rsync__args: ['--verbose', '--archive', '--delete', '-z', '--copy-links', '--chmod=ugo=rwX'],
      id: synced_folder['id'],
      create: synced_folder.fetch('create', false),
      mount_options: synced_folder.fetch('mount_options', []),
      nfs_udp: synced_folder.fetch('nfs_udp', false)
    }
<<<<<<< HEAD
    synced_folder.fetch('options_override', {}).each do |key, value|
      options[key.to_sym] = value
=======
    if synced_folder.include?('options_override')
      synced_folder['options_override'].each do |key, value|
        options[key.to_sym] = value
      end
>>>>>>> dd747fad95dbf3b776a00731ba9641b7f5e76343
    end
    config.vm.synced_folder synced_folder.fetch('local_path'), synced_folder.fetch('destination'), options
  end

<<<<<<< HEAD
=======
  # Allow override of the default synced folder type.
  config.vm.synced_folder host_project_dir, '/vagrant', type: vconfig['vagrant_synced_folder_default_type']

>>>>>>> dd747fad95dbf3b776a00731ba9641b7f5e76343
  config.vm.provision provisioner do |ansible|
    ansible.playbook = playbook
    ansible.extra_vars = {
      config_dir: config_dir,
      drupalvm_env: drupalvm_env
    }
<<<<<<< HEAD
    ansible.raw_arguments = Shellwords.shellsplit(ENV['DRUPALVM_ANSIBLE_ARGS']) if ENV['DRUPALVM_ANSIBLE_ARGS']
    ansible.tags = ENV['DRUPALVM_ANSIBLE_TAGS']
    # Use pip to get the latest Ansible version when using ansible_local.
    provisioner == :ansible_local && ansible.install_mode = 'pip'
=======
    ansible.raw_arguments = ENV['DRUPALVM_ANSIBLE_ARGS']
    ansible.tags = ENV['DRUPALVM_ANSIBLE_TAGS']
>>>>>>> dd747fad95dbf3b776a00731ba9641b7f5e76343
  end

  # VMware Fusion.
  config.vm.provider :vmware_fusion do |v, override|
    # HGFS kernel module currently doesn't load correctly for native shares.
    override.vm.synced_folder host_project_dir, '/vagrant', type: 'nfs'

    v.gui = vconfig['vagrant_gui']
    v.vmx['memsize'] = vconfig['vagrant_memory']
    v.vmx['numvcpus'] = vconfig['vagrant_cpus']
  end

  # VirtualBox.
  config.vm.provider :virtualbox do |v|
    v.linked_clone = true
    v.name = vconfig['vagrant_hostname']
    v.memory = vconfig['vagrant_memory']
    v.cpus = vconfig['vagrant_cpus']
    v.customize ['modifyvm', :id, '--natdnshostresolver1', 'on']
    v.customize ['modifyvm', :id, '--ioapic', 'on']
    v.gui = vconfig['vagrant_gui']
  end

  # Parallels.
  config.vm.provider :parallels do |p, override|
    override.vm.box = vconfig['vagrant_box']
    p.name = vconfig['vagrant_hostname']
    p.memory = vconfig['vagrant_memory']
    p.cpus = vconfig['vagrant_cpus']
    p.update_guest_tools = true
  end

  # Cache packages and dependencies if vagrant-cachier plugin is present.
  if Vagrant.has_plugin?('vagrant-cachier')
    config.cache.scope = :box
    config.cache.auto_detect = false
    config.cache.enable :apt
    # Cache the composer directory.
    config.cache.enable :generic, cache_dir: '/home/vagrant/.composer/cache'
    config.cache.synced_folder_opts = {
      type: vconfig['vagrant_synced_folder_default_type']
    }
  end

  # Allow an untracked Vagrantfile to modify the configurations
  [host_config_dir, host_project_dir].uniq.each do |dir|
    eval File.read "#{dir}/Vagrantfile.local" if File.exist?("#{dir}/Vagrantfile.local")
  end
end
