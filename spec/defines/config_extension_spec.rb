require 'spec_helper'

describe 'nxlog::config::extension', :type => :define do

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
        ext_module => 'xm_json',
        nxlog_root => 'C:/nxlog'
      }"
    end

    let(:title) { 'json' }

    describe 'builds an Extension section for the config file which' do
      it { should contain_concat__fragment('extension_json').with_content(/<Extension json>/) }
      it { should contain_concat__fragment('extension_json').with_content(/\s\sModule\s+xm_json/) }
      it { should contain_concat__fragment('extension_json').with_content(/<\/Extension>/) }
    end

  end

end
