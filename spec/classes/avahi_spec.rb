require 'spec_helper'

OPERATING_SYSTEMS = {
    'Debian' => {
        :package => 'avahi-daemon',
        :service => 'avahi-daemon',
    },
    'Redhat' => {
        :package => 'avahi',
        :service => 'avahi',
    }
}

describe 'avahi' do
  context 'supported operating systems' do
    OPERATING_SYSTEMS.each do |osfamily, values|
      describe "avahi class without any parameters on #{osfamily}" do
        let(:params) { {} }
        let(:facts) { {
            :osfamily => osfamily,
        } }

        it { should compile.with_all_deps }

        it { should contain_class('avahi::params') }
        it { should contain_class('avahi::install').that_comes_before('avahi::config') }
        it { should contain_class('avahi::config') }
        it { should contain_class('avahi::service').that_subscribes_to('avahi::config') }

        it { should contain_service(values[:service]) }
        it { should contain_package(values[:package]).with_ensure('present') }
      end
    end
  end

  context 'unsupported operating system' do
    describe 'avahi class without any parameters on Solaris/Nexenta' do
      let(:facts) { {
          :osfamily => 'Solaris',
          :operatingsystem => 'Nexenta',
      } }

      it { expect { should contain_package('avahi') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
