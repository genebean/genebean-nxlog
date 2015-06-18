require 'spec_helper'

describe 'nxlog::install' do

  context 'On a RedHat OS' do
    let :facts do
      {
          :kernel          => 'Linux',
          :osfamily        => 'RedHat',
          :operatingsystem => 'RedHat',
          :concat_basedir  => File.join(Puppet[:vardir],"concat")
      }
    end

    let :pre_condition do
      "class {'nxlog':
        conf_dir   => '/opt/nxlog/etc/nxlog/conf',
        conf_file  => 'nxlog.conf',
        nxlog_root => '/opt/nxlog/etc/nxlog',
      }"
    end

    it 'should install the latest version of NXLog by default' do
      should contain_package('nxlog').with(
                 'ensure' => 'latest',
             )
    end

    it "should use '/opt/nxlog/etc/nxlog/conf/nxlog.conf' as it's config file" do
      should contain_concat('/opt/nxlog/etc/nxlog/conf/nxlog.conf')
    end
  end

  context 'On Windows' do
    let :facts do
      {
          :kernel          => 'windows',
          :osfamily        => 'windows',
          :operatingsystem => 'windows',
          :concat_basedir  => File.join(Puppet[:vardir],"concat")
      }
    end

    let :pre_condition do
      "class {'nxlog':
        conf_dir   => 'C:/nxlog/conf',
        conf_file  => 'nxlog.conf',
        nxlog_root => 'C:/nxlog',
      }"
    end

    it 'should install the latest version of NXLog by default' do
      should contain_package('nxlog').with(
                 'ensure'   => 'latest',
                 'provider' => 'chocolatey',
             )
    end

    it "should use 'C:/nxlog/conf/nxlog.conf' as it's config file" do
      should contain_concat('C:/nxlog/conf/nxlog.conf')
    end
  end

end
