require 'spec_helper'

describe 'avahi::config' do
  describe "with parameters" do
    let(:params) { {
        :avahi_hostname     => 'sparta',
        :avahi_domainname   => 'get.coffee',
        :allow_interfaces   => ['eth1', 'eth2'],
        :deny_interfaces    => [],
        :enable_reflector   => true,
        :conf_dir           => '/etc/avahi',
        :daemon_config_file => 'avahi-daemon.conf',
    }}

    it { should compile.with_all_deps }
    
    it { should contain_file('/etc/avahi').with({
       :ensure => 'directory' 
    }) }
    
    it { should contain_file('/etc/avahi/avahi-daemon.conf')
      .with({ :mode => '0644' })
      .with_content(/^host-name=sparta$/)
      .with_content(/^domain-name=get.coffee$/)
      .with_content(/^allow-interfaces=eth1, ?eth2$/)
      .without_content(/^deny-interfaces=/)
      .with_content(/^enable-reflector=yes$/) }
  end
end
