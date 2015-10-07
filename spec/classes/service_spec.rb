require 'spec_helper'

describe 'nxlog::service' do

  context 'On Windows' do
    let :facts do
      {
          :kernel          => 'windows',
          :osfamily        => 'windows',
          :operatingsystem => 'windows',
          :concat_basedir  => File.join(Puppet[:vardir],"concat")
      }
    end

    describe 'with ensure_setting => latest' do

      let :pre_condition do
        "class {'nxlog':
          conf_dir   => 'C:/nxlog/conf',
          conf_file  => 'nxlog.conf',
          nxlog_root => 'C:/nxlog',
        }"
      end

      it 'should enable the nxlog service' do
        should contain_service('nxlog').with(
                 'ensure'    => 'running',
                 'enable'    => 'true',
                 'subscribe' => 'Concat[C:/nxlog/conf/nxlog.conf]'
               )
      end
    end

    describe 'with ensure_setting => absent' do

      it 'should not enable the nxlog service' do
        should !contain_service('nxlog')
      end
    end

  end

end
