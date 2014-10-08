require 'spec_helper'

describe 'avahi::service' do
  let(:facts) { {:osfamily => 'Redhat'} }
  let(:pre_condition) { "class { 'avahi': }" }

  describe 'with only required parameters' do
    let(:title) { 'Awesome but simple' }
    let(:params) { {
        :type => 'awesome-simple',
        :port => 1337
    } }

    it { should contain_file('/etc/avahi/services/awesome-but-simple.service')
                .with_content(/<name replace-wildcards="yes">Awesome but simple<\/name>/)
                .with_content(/<type>_awesome-simple._tcp<\/type>/)
                .with_content(/<port>1337<\/port>/) }
  end
end