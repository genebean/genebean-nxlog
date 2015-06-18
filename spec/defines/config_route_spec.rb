require 'spec_helper'

describe 'nxlog::config::route', :type => :define do

  context 'On Windows' do

    let :facts do
      {
          :kernel          => 'windows',
          :osfamily        => 'windows',
          :operatingsystem => 'windows',
          :concat_basedir  => File.join(Puppet[:vardir],"concat")
      }
    end

    describe 'routing a single source to a single destination' do
      let :pre_condition do
        "class {'nxlog':
          conf_dir          => 'C:/nxlog/conf',
          conf_file         => 'nxlog.conf',
          nxlog_root        => 'C:/nxlog',
          route_destination => [ 'logserver', ],
          route_source      => [ 'eventlog_json', ],
        }"
      end

      let(:title) { 'remote' }

      describe 'builds Route section for the config file which' do
        it { should contain_concat__fragment('route_remote').with_content(/<Route remote>/) }
        it { should contain_concat__fragment('route_remote').with_content(/\s\sPath\s+eventlog_json\s=>\slogserver/) }
        it { should contain_concat__fragment('route_remote').with_content(/<\/Route>/) }
      end
    end

    describe 'routing a single source to two destinations' do
      let :pre_condition do
        "class {'nxlog':
          conf_dir          => 'C:/nxlog/conf',
          conf_file         => 'nxlog.conf',
          nxlog_root        => 'C:/nxlog',
          route_destination => [ 'logserver', 'local_file' ],
          route_source      => [ 'eventlog_json', ],
        }"
      end

      let(:title) { 'remote' }

      describe 'builds Route section for the config file which' do
        it { should contain_concat__fragment('route_remote').with_content(/<Route remote>/) }
        it { should contain_concat__fragment('route_remote').with_content(/\s\sPath\s+eventlog_json\s=>\slogserver,local_file/) }
        it { should contain_concat__fragment('route_remote').with_content(/<\/Route>/) }
      end
    end

    describe 'routing a two sources to a single destination' do
      let :pre_condition do
        "class {'nxlog':
          conf_dir          => 'C:/nxlog/conf',
          conf_file         => 'nxlog.conf',
          nxlog_root        => 'C:/nxlog',
          route_destination => [ 'logserver', ],
          route_source      => [ 'eventlog_json', 'app_log', ],
        }"
      end

      let(:title) { 'remote' }

      describe 'builds Route section for the config file which' do
        it { should contain_concat__fragment('route_remote').with_content(/<Route remote>/) }
        it { should contain_concat__fragment('route_remote').with_content(/\s\sPath\s+eventlog_json,app_log\s=>\slogserver/) }
        it { should contain_concat__fragment('route_remote').with_content(/<\/Route>/) }
      end
    end

    describe 'routing two sources to two destinations' do
      let :pre_condition do
        "class {'nxlog':
          conf_dir          => 'C:/nxlog/conf',
          conf_file         => 'nxlog.conf',
          nxlog_root        => 'C:/nxlog',
          route_destination => [ 'logserver', 'local_file' ],
          route_source      => [ 'eventlog_json', 'app_log', ],
        }"
      end

      let(:title) { 'remote' }

      describe 'builds a Route section for the config file which' do
        it { should contain_concat__fragment('route_remote').with_content(/<Route remote>/) }
        it { should contain_concat__fragment('route_remote').with_content(/\s\sPath\s+eventlog_json,app_log\s=>\slogserver,local_file/) }
        it { should contain_concat__fragment('route_remote').with_content(/<\/Route>/) }
      end
    end

  end

end
